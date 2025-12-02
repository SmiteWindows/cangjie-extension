<#
.SYNOPSIS
    GUI Script Launcher for Cangjie Extension using Windows Forms.

.DESCRIPTION
    This script provides a graphical user interface to launch and manage PowerShell scripts for the Cangjie Extension project.
    It categorizes scripts and provides detailed information about each script before launching.

.PARAMETER SettingsFile
    The path to the settings file. Defaults to gui-script-launcher-settings.json in the script directory.

.EXAMPLE
    .\gui-script-launcher.ps1
    Launches the GUI script launcher with default settings.

.EXAMPLE
    .\gui-script-launcher.ps1 -SettingsFile "C:\MySettings.json"
    Launches the GUI script launcher with a custom settings file.

.NOTES
    This script requires PowerShell 7 or later and Windows Forms.
    It provides a modern, user-friendly interface for managing and launching project scripts.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$SettingsFile
)

# Check if running on Windows
if (-not $IsWindows) {
    Write-Host "此 GUI 启动器仅支持 Windows 系统。" -ForegroundColor Red
    exit 1
}

# Import necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Set script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define settings file path
$SettingsFile = Join-Path $ScriptDir "gui-script-launcher-settings.json"

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
    SplitterDistance = 350
    ShowStatusBar = $true
    AutoExpandCategories = $true
}

# Load settings from file
function Load-Settings {
    if (Test-Path $SettingsFile) {
        try {
            $loadedSettings = Get-Content  -Encoding UTF8 ConvertFrom-Json
            return $loadedSettings
        } catch {
            Write-Host "加载设置失败，使用默认设置。" -ForegroundColor Yellow
            return $DefaultSettings
        }
    } else {
        return $DefaultSettings
    }
}

# Save settings to file
function Save-Settings {
    <#
    .SYNOPSIS
        Saves settings to the settings file.
    
    .DESCRIPTION
        Writes the provided settings hashtable to the specified settings file in JSON format.
    
    .PARAMETER Settings
        The hashtable of settings to save to the file.
    #>
    param(
        [hashtable]$Settings
    )
    try {
        $Settings | ConvertTo-Json | Out-File -FilePath $SettingsFile -Encoding UTF8
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
        @{ Name = "gui-script-launcher.ps1"; Path = "gui-script-launcher.ps1"; Description = "GUI 脚本启动器" }
    )
}

# Create main form
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Cangjie Extension 脚本启动器"
$Form.Size = New-Object System.Drawing.Size(900, 700)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "Sizable"
$Form.MaximizeBox = $true
$Form.MinimizeBox = $true
$Form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)

# Add modern styling
$Form.Add_Shown({
    # Enable visual styles for modern look
    [System.Windows.Forms.Application]::EnableVisualStyles()
})

# Create split container for better layout
$SplitContainer = New-Object System.Windows.Forms.SplitContainer
$SplitContainer.Dock = [System.Windows.Forms.DockStyle]::Fill
$SplitContainer.Orientation = [System.Windows.Forms.Orientation]::Horizontal
$SplitContainer.SplitterDistance = 350
$SplitContainer.BackColor = [System.Drawing.Color]::White
$SplitContainer.Panel1.BackColor = [System.Drawing.Color]::White
$SplitContainer.Panel2.BackColor = [System.Drawing.Color]::White
$Form.Controls.Add($SplitContainer)

# Create TreeView for script categories and scripts
$TreeView = New-Object System.Windows.Forms.TreeView
$TreeView.Dock = [System.Windows.Forms.DockStyle]::Fill
$TreeView.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 10)
$TreeView.ShowLines = $true
$TreeView.ShowPlusMinus = $true
$TreeView.ShowRootLines = $true
$TreeView.BackColor = [System.Drawing.Color]::White
$TreeView.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$TreeView.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$TreeView.HotTracking = $true
$TreeView.FullRowSelect = $true
$SplitContainer.Panel1.Controls.Add($TreeView)

# Create details panel
$DetailsPanel = New-Object System.Windows.Forms.Panel
$DetailsPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$DetailsPanel.Padding = New-Object System.Windows.Forms.Padding(20)
$DetailsPanel.BackColor = [System.Drawing.Color]::White
$SplitContainer.Panel2.Controls.Add($DetailsPanel)

# Create header label
$HeaderLabel = New-Object System.Windows.Forms.Label
$HeaderLabel.Text = "Cangjie Extension 脚本启动器" 
$HeaderLabel.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 14, [System.Drawing.FontStyle]::Bold)
$HeaderLabel.Location = New-Object System.Drawing.Point(20, 10)
$HeaderLabel.AutoSize = $true
$HeaderLabel.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$DetailsPanel.Controls.Add($HeaderLabel)

# Create description label
$DescriptionLabel = New-Object System.Windows.Forms.Label
$DescriptionLabel.Text = "脚本详情:" 
$DescriptionLabel.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 11, [System.Drawing.FontStyle]::Bold)
$DescriptionLabel.Location = New-Object System.Drawing.Point(20, 50)
$DescriptionLabel.AutoSize = $true
$DescriptionLabel.ForeColor = [System.Drawing.Color]::FromArgb(60, 60, 60)
$DetailsPanel.Controls.Add($DescriptionLabel)

# Create details textbox with modern styling
$DetailsTextBox = New-Object System.Windows.Forms.TextBox
$DetailsTextBox.Multiline = $true
$DetailsTextBox.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
$DetailsTextBox.ReadOnly = $true
$DetailsTextBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$DetailsTextBox.Location = New-Object System.Drawing.Point(20, 80)
$DetailsTextBox.Size = New-Object System.Drawing.Size(840, 180)
$DetailsTextBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
$DetailsTextBox.BackColor = [System.Drawing.Color]::FromArgb(250, 250, 250)
$DetailsTextBox.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$DetailsTextBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$DetailsTextBox.Padding = New-Object System.Windows.Forms.Padding(8)
$DetailsPanel.Controls.Add($DetailsTextBox)

# Create menu strip
$MenuStrip = New-Object System.Windows.Forms.MenuStrip
$MenuStrip.BackColor = [System.Drawing.Color]::White
$MenuStrip.ForeColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$MenuStrip.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 10)

# File menu
$FileMenu = New-Object System.Windows.Forms.ToolStripMenuItem("文件")
$ExitMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("退出")
$ExitMenuItem.Add_Click({
    $Form.Close()
})
$FileMenu.DropDownItems.Add($ExitMenuItem) | Out-Null
$MenuStrip.Items.Add($FileMenu) | Out-Null

# Settings menu
$SettingsMenu = New-Object System.Windows.Forms.ToolStripMenuItem("设置")
$EditSettingsMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("编辑设置")
$SaveSettingsMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("保存设置")
$RestoreDefaultsMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("恢复默认设置")

$EditSettingsMenuItem.Add_Click({
    # Create settings form
    $SettingsForm = New-Object System.Windows.Forms.Form
    $SettingsForm.Text = "脚本启动器设置"
    $SettingsForm.Size = New-Object System.Drawing.Size(500, 600)
    $SettingsForm.StartPosition = "CenterParent"
    $SettingsForm.FormBorderStyle = "FixedDialog"
    $SettingsForm.MaximizeBox = $false
    $SettingsForm.MinimizeBox = $false
    $SettingsForm.BackColor = [System.Drawing.Color]::White
    
    # Create tab control
    $TabControl = New-Object System.Windows.Forms.TabControl
    $TabControl.Dock = [System.Windows.Forms.DockStyle]::Fill
    $SettingsForm.Controls.Add($TabControl)
    
    # General settings tab
    $GeneralTab = New-Object System.Windows.Forms.TabPage("常规")
    $TabControl.TabPages.Add($GeneralTab)
    
    # Add settings controls here (simplified for brevity)
    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "设置功能正在开发中，敬请期待！"
    $Label.Location = New-Object System.Drawing.Point(20, 20)
    $Label.AutoSize = $true
    $GeneralTab.Controls.Add($Label)
    
    # Show settings form
    $SettingsForm.ShowDialog($Form) | Out-Null
})

$SaveSettingsMenuItem.Add_Click({
    Save-Settings -Settings $Settings
    [System.Windows.Forms.MessageBox]::Show("设置已保存。", "信息", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$RestoreDefaultsMenuItem.Add_Click({
    if ([System.Windows.Forms.MessageBox]::Show("确定要恢复默认设置吗？", "确认", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question) -eq [System.Windows.Forms.DialogResult]::Yes) {
        $Settings = $DefaultSettings
        [System.Windows.Forms.MessageBox]::Show("已恢复默认设置。", "信息", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

$SettingsMenu.DropDownItems.Add($EditSettingsMenuItem) | Out-Null
$SettingsMenu.DropDownItems.Add($SaveSettingsMenuItem) | Out-Null
$SettingsMenu.DropDownItems.Add($RestoreDefaultsMenuItem) | Out-Null
$MenuStrip.Items.Add($SettingsMenu) | Out-Null

# Help menu
$HelpMenu = New-Object System.Windows.Forms.ToolStripMenuItem("帮助")
$AboutMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("关于")
$AboutMenuItem.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Cangjie Extension 脚本启动器 v1.0\n\n用于管理和运行 Cangjie 项目的 PowerShell 脚本。", "关于", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})
$HelpMenu.DropDownItems.Add($AboutMenuItem) | Out-Null
$MenuStrip.Items.Add($HelpMenu) | Out-Null

$Form.MainMenuStrip = $MenuStrip
$Form.Controls.Add($MenuStrip)

# Create button panel with modern styling
$ButtonPanel = New-Object System.Windows.Forms.Panel
$ButtonPanel.Dock = [System.Windows.Forms.DockStyle]::Bottom
$ButtonPanel.Height = 80
$ButtonPanel.Padding = New-Object System.Windows.Forms.Padding(20)
$ButtonPanel.BackColor = [System.Drawing.Color]::FromArgb(245, 245, 245)
$ButtonPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$Form.Controls.Add($ButtonPanel)

# Create launch button with modern styling
$LaunchButton = New-Object System.Windows.Forms.Button
$LaunchButton.Text = "🚀 启动脚本"
$LaunchButton.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 11, [System.Drawing.FontStyle]::Bold)
$LaunchButton.Location = New-Object System.Drawing.Point(20, 15)
$LaunchButton.Size = New-Object System.Drawing.Size(140, 50)
$LaunchButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 212)
$LaunchButton.ForeColor = [System.Drawing.Color]::White
$LaunchButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$LaunchButton.FlatAppearance.BorderSize = 0
$LaunchButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$LaunchButton.Add_MouseEnter({
    $LaunchButton.BackColor = [System.Drawing.Color]::FromArgb(0, 100, 180)
})
$LaunchButton.Add_MouseLeave({
    $LaunchButton.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 212)
})
$ButtonPanel.Controls.Add($LaunchButton)

# Create exit button with modern styling
$ExitButton = New-Object System.Windows.Forms.Button
$ExitButton.Text = "❌ 退出"
$ExitButton.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 11)
$ExitButton.Location = New-Object System.Drawing.Point(170, 15)
$ExitButton.Size = New-Object System.Drawing.Size(120, 50)
$ExitButton.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
$ExitButton.ForeColor = [System.Drawing.Color]::White
$ExitButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$ExitButton.FlatAppearance.BorderSize = 0
$ExitButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$ExitButton.Add_MouseEnter({
    $ExitButton.BackColor = [System.Drawing.Color]::FromArgb(200, 35, 51)
})
$ExitButton.Add_MouseLeave({
    $ExitButton.BackColor = [System.Drawing.Color]::FromArgb(220, 53, 69)
})
$ButtonPanel.Controls.Add($ExitButton)

# Create status strip with modern styling
$StatusStrip = New-Object System.Windows.Forms.StatusStrip
$StatusStrip.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 240)
$StatusStrip.ForeColor = [System.Drawing.Color]::FromArgb(80, 80, 80)
$StatusStrip.Font = New-Object System.Drawing.Font("Microsoft YaHei UI", 9)
$StatusStrip.Padding = New-Object System.Windows.Forms.Padding(10, 0, 10, 0)

$StatusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$StatusLabel.Text = "就绪 - 请选择一个脚本"
$StatusLabel.Spring = $false
$StatusStrip.Items.Add($StatusLabel)

$VersionLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$VersionLabel.Text = "v1.0.0"
$VersionLabel.Alignment = [System.Windows.Forms.ToolStripItemAlignment]::Right
$StatusStrip.Items.Add($VersionLabel)

$Form.Controls.Add($StatusStrip)

# Populate TreeView with script categories and scripts
function Populate-TreeView {
    $TreeView.Nodes.Clear()
    
    foreach ($Category in $ScriptCategories.Keys | Sort-Object) {
        $CategoryNode = $TreeView.Nodes.Add($Category)
        $CategoryNode.Tag = "Category"
        $CategoryNode.ImageIndex = 0
        $CategoryNode.SelectedImageIndex = 0
        
        foreach ($Script in $ScriptCategories[$Category]) {
            $ScriptNode = $CategoryNode.Nodes.Add($Script.Name)
            $ScriptNode.Tag = $Script
            $ScriptNode.ToolTipText = $Script.Description
            $ScriptNode.ImageIndex = 1
            $ScriptNode.SelectedImageIndex = 1
        }
        
        # Expand all category nodes
        $CategoryNode.Expand()
    }
}

# Show script details when node is selected
$TreeView.add_AfterSelect({
    param($sender, $e)
    
    $SelectedNode = $e.Node
    if ($SelectedNode.Tag -is [hashtable]) {
        $Script = $SelectedNode.Tag
        $Details = @(
            "名称: $($Script.Name)",
            "路径: $($Script.Path)",
            "完整路径: $(Join-Path $ScriptDir $Script.Path)",
            "描述: $($Script.Description)",
            ""
        )
        $DetailsTextBox.Text = $Details -join "`r`n"
        $LaunchButton.Enabled = $true
        $StatusLabel.Text = "已选择脚本: $($Script.Name)"
    } else {
        $DetailsTextBox.Text = "请选择一个脚本查看详情。"
        $LaunchButton.Enabled = $false
        $StatusLabel.Text = "已选择分类: $($SelectedNode.Text)"
    }
})

# Launch script when button is clicked
$LaunchButton.add_Click({
    $SelectedNode = $TreeView.SelectedNode
    if ($SelectedNode -and $SelectedNode.Tag -is [hashtable]) {
        $Script = $SelectedNode.Tag
        $FullPath = Join-Path $ScriptDir $Script.Path
        
        try {
            $StatusLabel.Text = "正在启动脚本: $($Script.Name)..."
            $Form.Refresh()
            
            # Run the script in the current terminal
            try {
                # Execute the script directly in the current PowerShell session
                & "$FullPath"
            } catch {
                [System.Windows.Forms.MessageBox]::Show("脚本执行出错: $($_.Exception.Message)", "错误", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            }
            
            $StatusLabel.Text = "脚本已启动: $($Script.Name)"
        } catch {
            [System.Windows.Forms.MessageBox]::Show("启动脚本失败: $($_.Exception.Message)", "错误", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            $StatusLabel.Text = "启动脚本失败: $($Script.Name)"
        }
    }
})

# Exit when button is clicked
$ExitButton.add_Click({
    $Form.Close()
})

# Handle form closing
$Form.add_FormClosing({
    $StatusLabel.Text = "正在退出..."
    $Form.Refresh()
})

# Initialize TreeView
Populate-TreeView

# Set initial state
$DetailsTextBox.Text = "请选择一个脚本查看详情。"
$LaunchButton.Enabled = $false

# Show the form
[System.Windows.Forms.Application]::Run($Form)

