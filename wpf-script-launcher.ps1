<#
.SYNOPSIS
    WPF Script Launcher for Cangjie Extension.

.DESCRIPTION
    This script provides a modern Windows Presentation Foundation (WPF) interface to launch and manage PowerShell scripts for the Cangjie Extension project.
    It categorizes scripts and provides detailed information about each script before launching.

.PARAMETER SettingsFile
    The path to the settings file. Defaults to wpf-script-launcher-settings.json in the script directory.

.EXAMPLE
    .\wpf-script-launcher.ps1
    Launches the WPF script launcher with default settings.

.EXAMPLE
    .\wpf-script-launcher.ps1 -SettingsFile "C:\MySettings.json"
    Launches the WPF script launcher with a custom settings file.

.NOTES
    This script requires PowerShell 7 or later and Windows Presentation Foundation (WPF).
    It provides a modern, user-friendly interface for managing and launching project scripts.
    Only works on Windows systems that support WPF.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

#!/usr/bin/env pwsh
# WPF Script Launcher for Cangjie Extension

param(
    [string]$SettingsFile
)

# Check if running on Windows
if (-not $IsWindows) {
    Write-Host "此 WPF 启动器仅支持 Windows 系统。" -ForegroundColor Red
    exit 1
}

# Check if WPF is available
Add-Type -AssemblyName PresentationFramework -ErrorAction SilentlyContinue
if (-not ([System.Management.Automation.PSTypeName]'System.Windows.Window').Type) {
    Write-Host "无法加载 WPF 程序集。请确保在支持 WPF 的 Windows 环境中运行。" -ForegroundColor Red
    exit 1
}

# Set script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define settings file path
if ([string]::IsNullOrEmpty($SettingsFile)) {
    $SettingsFile = Join-Path $ScriptDir "wpf-script-launcher-settings.json"
}

# Default settings
$DefaultSettings = @{
    ExecutionPolicy = "RemoteSigned"
    Verbose = $false
    Debug = $false
    ErrorActionPreference = "Continue"
    WorkingDirectory = $ScriptDir
    ShowScriptOutput = $true
    SaveLastSelection = $true
    LastSelectedCategory = ""
    LastSelectedScript = ""
    WindowWidth = 900
    WindowHeight = 700
    TreeViewWidth = 300
    ShowStatusBar = $true
    AutoExpandCategories = $true
    FontSize = 12
    Theme = "Light"
}

# Load current settings
$Settings = Load-Settings -FilePath $SettingsFile

# Save settings to file
function Save-Settings {
    param(
        [hashtable]$Settings,
        [string]$FilePath
    )
    try {
        $Settings | ConvertTo-Json | Out-File -FilePath $FilePath -Encoding UTF8
        Write-Host "设置已保存。" -ForegroundColor Green
    } catch {
        Write-Host "保存设置失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Load current settings
$Settings = Load-Settings

# Define script categories and their scripts
$ScriptCategories = @{
    "测试验证脚本" = @(
        @{ Name = "test_script.ps1"; Path = "tree-sitter-cangjie/tests/test_verification/test_script.ps1"; Description = "Cangjie 语法验证测试脚本，随机选择测试文件并生成详细报告" }
        @{ Name = "generate_report.ps1"; Path = "tree-sitter-cangjie/tests/test_verification/generate_report.ps1"; Description = "生成测试报告脚本" }
        @{ Name = "final_report.ps1"; Path = "tree-sitter-cangjie/tests/test_verification/final_report.ps1"; Description = "最终测试报告生成脚本" }
        @{ Name = "test-report.ps1"; Path = "tree-sitter-cangjie/test-report.ps1"; Description = "测试报告生成脚本" }
        @{ Name = "build-test-all.ps1"; Path = "build-test-all.ps1"; Description = "构建并测试所有组件脚本" }
    )
    
    "项目维护脚本" = @(
        @{ Name = "update-dependencies.ps1"; Path = "update-dependencies.ps1"; Description = "更新项目依赖脚本" }
        @{ Name = "tree-sitter-cangjie 更新依赖"; Path = "tree-sitter-cangjie/update-dependencies.ps1"; Description = "更新 tree-sitter-cangjie 依赖脚本" }
        @{ Name = "grammars/cangjie 更新依赖"; Path = "grammars/cangjie/update-dependencies.ps1"; Description = "更新 grammars/cangjie 依赖脚本" }
        @{ Name = "bump-version.ps1"; Path = "bump-version.ps1"; Description = "版本号更新脚本" }
        @{ Name = "tree-sitter-cangjie 版本更新"; Path = "tree-sitter-cangjie/bump-version.ps1"; Description = "tree-sitter-cangjie 版本号更新脚本" }
        @{ Name = "grammars/cangjie 版本更新"; Path = "grammars/cangjie/bump-version.ps1"; Description = "grammars/cangjie 版本号更新脚本" }
        @{ Name = "generate-changelog.ps1"; Path = "generate-changelog.ps1"; Description = "生成变更日志脚本" }
        @{ Name = "tree-sitter-cangjie 生成变更日志"; Path = "tree-sitter-cangjie/generate-changelog.ps1"; Description = "tree-sitter-cangjie 生成变更日志脚本" }
        @{ Name = "grammars/cangjie 生成变更日志"; Path = "grammars/cangjie/generate-changelog.ps1"; Description = "grammars/cangjie 生成变更日志脚本" }
        @{ Name = "update-ps1-scripts.ps1"; Path = "update-ps1-scripts.ps1"; Description = "更新 PowerShell 脚本脚本" }
        @{ Name = "tree-sitter-cangjie 更新 PS1 脚本"; Path = "tree-sitter-cangjie/update-ps1-scripts.ps1"; Description = "tree-sitter-cangjie 更新 PowerShell 脚本脚本" }
        @{ Name = "grammars/cangjie 更新 PS1 脚本"; Path = "grammars/cangjie/update-ps1-scripts.ps1"; Description = "grammars/cangjie 更新 PowerShell 脚本脚本" }
    )
    
    "验证脚本" = @(
        @{ Name = "validate-ps1-simple.ps1"; Path = "validate-ps1-simple.ps1"; Description = "简单 PowerShell 脚本验证" }
        @{ Name = "tree-sitter-cangjie 简单验证"; Path = "tree-sitter-cangjie/validate-ps1-simple.ps1"; Description = "tree-sitter-cangjie 简单 PowerShell 脚本验证" }
        @{ Name = "grammars/cangjie 简单验证"; Path = "grammars/cangjie/validate-ps1-simple.ps1"; Description = "grammars/cangjie 简单 PowerShell 脚本验证" }
        @{ Name = "validate-project-ps1.ps1"; Path = "validate-project-ps1.ps1"; Description = "项目 PowerShell 脚本验证" }
        @{ Name = "tree-sitter-cangjie 项目验证"; Path = "tree-sitter-cangjie/validate-project-ps1.ps1"; Description = "tree-sitter-cangjie 项目 PowerShell 脚本验证" }
        @{ Name = "grammars/cangjie 项目验证"; Path = "grammars/cangjie/validate-project-ps1.ps1"; Description = "grammars/cangjie 项目 PowerShell 脚本验证" }
    )
    
    "Tree-sitter 工具脚本" = @(
        @{ Name = "tree-sitter-tools.ps1"; Path = "tree-sitter-tools.ps1"; Description = "Tree-sitter 工具脚本" }
        @{ Name = "tree-sitter-cangjie 工具"; Path = "tree-sitter-cangjie/tree-sitter-tools.ps1"; Description = "tree-sitter-cangjie Tree-sitter 工具脚本" }
        @{ Name = "grammars/cangjie Tree-sitter 工具"; Path = "grammars/cangjie/tree-sitter-tools.ps1"; Description = "grammars/cangjie Tree-sitter 工具脚本" }
    )
    
    "WASM 相关脚本" = @(
        @{ Name = "test-wasm-module.ps1"; Path = "test-wasm-module.ps1"; Description = "测试 WASM 模块脚本" }
        @{ Name = "tree-sitter-cangjie 测试 WASM"; Path = "tree-sitter-cangjie/test-wasm-module.ps1"; Description = "tree-sitter-cangjie 测试 WASM 模块脚本" }
        @{ Name = "grammars/cangjie 测试 WASM"; Path = "grammars/cangjie/test-wasm-module.ps1"; Description = "grammars/cangjie 测试 WASM 模块脚本" }
        @{ Name = "setup-wasi-sdk.ps1"; Path = "setup-wasi-sdk.ps1"; Description = "设置 WASI SDK 脚本" }
        @{ Name = "tree-sitter-cangjie 设置 WASI SDK"; Path = "tree-sitter-cangjie/setup-wasi-sdk.ps1"; Description = "tree-sitter-cangjie 设置 WASI SDK 脚本" }
        @{ Name = "grammars/cangjie 设置 WASI SDK"; Path = "grammars/cangjie/setup-wasi-sdk.ps1"; Description = "grammars/cangjie 设置 WASI SDK 脚本" }
    )
    
    "配置文件" = @(
        @{ Name = "profile.ps1"; Path = "profile.ps1"; Description = "PowerShell 配置文件" }
        @{ Name = "tree-sitter-cangjie 配置文件"; Path = "tree-sitter-cangjie/profile.ps1"; Description = "tree-sitter-cangjie PowerShell 配置文件" }
        @{ Name = "grammars/cangjie 配置文件"; Path = "grammars/cangjie/profile.ps1"; Description = "grammars/cangjie PowerShell 配置文件" }
    )
    
    "其他脚本" = @(
        @{ Name = "add-pwsh7-config.ps1"; Path = "add-pwsh7-config.ps1"; Description = "添加 PowerShell 7 配置脚本" }
        @{ Name = "setup-cangjie-sdk.ps1"; Path = "setup-cangjie-sdk.ps1"; Description = "设置 Cangjie SDK 脚本" }
        @{ Name = "fix-test-script.ps1"; Path = "tree-sitter-cangjie/fix-test-script.ps1"; Description = "修复测试脚本脚本" }
        @{ Name = "test-launcher.ps1"; Path = "test-launcher.ps1"; Description = "测试脚本启动器功能" }
        @{ Name = "script-launcher.ps1"; Path = "script-launcher.ps1"; Description = "PowerShell 脚本启动器" }
        @{ Name = "gui-script-launcher.ps1"; Path = "gui-script-launcher.ps1"; Description = "Windows Forms GUI 脚本启动器" }
        @{ Name = "wpf-script-launcher.ps1"; Path = "wpf-script-launcher.ps1"; Description = "WPF 脚本启动器" }
    )
}

# Define XAML for the WPF window
$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Cangjie Extension 脚本启动器"
        Width="900"
        Height="700"
        MinWidth="700"
        MinHeight="500"
        Background="#F5F5F5"
        WindowStartupLocation="CenterScreen">
    
    <Window.Resources>
        <!-- Modern styles -->
        <Style TargetType="Button" x:Key="ModernButton">
            <Setter Property="Background" Value="#0078D4"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontFamily" Value="Microsoft YaHei UI"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="12,8"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#005A9E"/>
                </Trigger>
                <Trigger Property="IsPressed" Value="True">
                    <Setter Property="Background" Value="#004578"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        
        <Style TargetType="Button" x:Key="DangerButton" BasedOn="{StaticResource ModernButton}">
            <Setter Property="Background" Value="#D13438"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#A82A2E"/>
                </Trigger>
                <Trigger Property="IsPressed" Value="True">
                    <Setter Property="Background" Value="#8B1E21"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        
        <Style TargetType="TreeViewItem">
            <Setter Property="FontFamily" Value="Microsoft YaHei UI"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="Foreground" Value="#202124"/>
            <Setter Property="Padding" Value="4,2"/>
            <Style.Triggers>
                <Trigger Property="IsSelected" Value="True">
                    <Setter Property="Background" Value="#E8F0FE"/>
                    <Setter Property="Foreground" Value="#1967D2"/>
                </Trigger>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#F1F3F4"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        
        <Style TargetType="Label">
            <Setter Property="FontFamily" Value="Microsoft YaHei UI"/>
            <Setter Property="Foreground" Value="#202124"/>
        </Style>
        
        <Style TargetType="TextBlock">
            <Setter Property="FontFamily" Value="Microsoft YaHei UI"/>
            <Setter Property="Foreground" Value="#202124"/>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <!-- Header -->
        <Border Grid.Row="0" Background="White" BorderBrush="#E0E0E0" BorderThickness="0,0,0,1" Padding="20">
            <StackPanel>
                <TextBlock Text="Cangjie Extension 脚本启动器" FontSize="18" FontWeight="Bold" Margin="0,5,0,5"/>
                <TextBlock Text="选择一个脚本以查看详情并启动" FontSize="12" Foreground="#666"/>
            </StackPanel>
        </Border>
        
        <!-- Main Content -->
        <Grid Grid.Row="1" Margin="0">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="300"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>
            
            <!-- Script TreeView -->
            <Border Grid.Column="0" Background="White" BorderBrush="#E0E0E0" BorderThickness="0,0,1,0">
                <TreeView Name="ScriptTreeView" Background="White" BorderThickness="0" Padding="10">
                    <TreeView.ItemContainerStyle>
                        <Style TargetType="TreeViewItem">
                            <Setter Property="IsExpanded" Value="True"/>
                        </Style>
                    </TreeView.ItemContainerStyle>
                </TreeView>
            </Border>
            
            <!-- Details Panel -->
            <Border Grid.Column="1" Background="White" Padding="20">
                <StackPanel>
                    <Label Content="脚本详情" FontSize="14" FontWeight="Bold" Margin="0,0,0,10"/>
                    
                    <ScrollViewer VerticalScrollBarVisibility="Auto" MaxHeight="400">
                        <TextBox Name="DetailsTextBox" 
                                 IsReadOnly="True" 
                                 FontFamily="Consolas" 
                                 FontSize="11" 
                                 Background="#F8F9FA" 
                                 BorderBrush="#E0E0E0" 
                                 BorderThickness="1" 
                                 Padding="10" 
                                 TextWrapping="Wrap" 
                                 AcceptsReturn="True" 
                                 MinHeight="200"/>
                    </ScrollViewer>
                    
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="0,20,0,0">
                        <Button Name="LaunchButton" Content="🚀 启动脚本" Style="{StaticResource ModernButton}" IsEnabled="False"/>
                        <Button Name="ExitButton" Content="❌ 退出" Style="{StaticResource DangerButton}"/>
                    </StackPanel>
                </StackPanel>
            </Border>
        </Grid>
        
        <!-- Status Bar -->
        <Border Grid.Row="2" Background="#F1F3F4" BorderBrush="#E0E0E0" BorderThickness="1,0,0,0" Padding="15,8">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Stretch">
                <TextBlock Name="StatusText" Text="就绪 - 请选择一个脚本" FontSize="11" Foreground="#666"/>
                <TextBlock Name="VersionText" Text="v1.0.0" FontSize="11" Foreground="#666" HorizontalAlignment="Right" Margin="0,0,0,0"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

# Create the WPF window
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]$XAML)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# Get UI elements
$ScriptTreeView = $window.FindName("ScriptTreeView")
$DetailsTextBox = $window.FindName("DetailsTextBox")
$LaunchButton = $window.FindName("LaunchButton")
$ExitButton = $window.FindName("ExitButton")
$StatusText = $window.FindName("StatusText")
$VersionText = $window.FindName("VersionText")

# Populate TreeView with script categories and scripts
function Populate-TreeView {
    $ScriptTreeView.Items.Clear()
    
    foreach ($Category in $ScriptCategories.Keys | Sort-Object) {
        $CategoryItem = New-Object System.Windows.Controls.TreeViewItem
        $CategoryItem.Header = $Category
        $CategoryItem.Tag = "Category"
        
        foreach ($Script in $ScriptCategories[$Category]) {
            $ScriptItem = New-Object System.Windows.Controls.TreeViewItem
            $ScriptItem.Header = $Script.Name
            $ScriptItem.Tag = $Script
            $ScriptItem.ToolTip = $Script.Description
            $CategoryItem.Items.Add($ScriptItem) | Out-Null
        }
        
        $ScriptTreeView.Items.Add($CategoryItem) | Out-Null
    }
}

# Show script details when item is selected
$ScriptTreeView.Add_SelectedItemChanged({
    param($sender, $e)
    
    $SelectedItem = $e.NewValue
    if ($SelectedItem -and $SelectedItem.Tag -is [hashtable]) {
        $Script = $SelectedItem.Tag
        $Details = @(
            "名称: $($Script.Name)",
            "路径: $($Script.Path)",
            "完整路径: $(Join-Path $ScriptDir $Script.Path)",
            "描述: $($Script.Description)",
            ""
        )
        $DetailsTextBox.Text = $Details -join "`r`n"
        $LaunchButton.IsEnabled = $true
        $StatusText.Text = "已选择脚本: $($Script.Name)"
    } else {
        $DetailsTextBox.Text = "请选择一个脚本查看详情。"
        $LaunchButton.IsEnabled = $false
        if ($SelectedItem) {
            $StatusText.Text = "已选择分类: $($SelectedItem.Header)"
        } else {
            $StatusText.Text = "就绪 - 请选择一个脚本"
        }
    }
})

# Launch script when button is clicked
$LaunchButton.Add_Click({
    $SelectedItem = $ScriptTreeView.SelectedItem
    if ($SelectedItem -and $SelectedItem.Tag -is [hashtable]) {
        $Script = $SelectedItem.Tag
        $FullPath = Join-Path $ScriptDir $Script.Path
        
        try {
            $StatusText.Text = "正在启动脚本: $($Script.Name)..."
            $window.Dispatcher.Invoke([Action]{})
            
            # Run the script in the current terminal
            try {
                # Execute the script directly in the current PowerShell session
                & "$FullPath"
            } catch {
                [System.Windows.MessageBox]::Show("脚本执行出错: $($_.Exception.Message)", "错误", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
            }
            
            $StatusText.Text = "脚本已启动: $($Script.Name)"
        } catch {
            [System.Windows.MessageBox]::Show("启动脚本失败: $($_.Exception.Message)", "错误", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
            $StatusText.Text = "启动脚本失败: $($Script.Name)"
        }
    }
})

# Exit when button is clicked
$ExitButton.Add_Click({
    $window.Close()
})

# Initialize
Populate-TreeView
$DetailsTextBox.Text = "请选择一个脚本查看详情。"

# Show the window
$window.ShowDialog() | Out-Null

