<#
.SYNOPSIS
    Command-line Script Launcher for Cangjie Extension.

.DESCRIPTION
    This script provides a command-line interface to launch and manage PowerShell scripts for the Cangjie Extension project.
    It categorizes scripts and provides detailed information about each script before launching.

.PARAMETER SettingsFile
    The path to the settings file. Defaults to script-launcher-settings.json in the script directory.

.EXAMPLE
    .\script-launcher.ps1
    Launches the command-line script launcher with default settings.

.EXAMPLE
    .\script-launcher.ps1 -SettingsFile "C:\MySettings.json"
    Launches the script launcher with a custom settings file.

.NOTES
    This script requires PowerShell 7 or later.
    It provides a simple, text-based interface for managing project scripts.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$SettingsFile
)

# Ensure PowerShell 7 environment
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7 or later." -ForegroundColor Red
    exit 1
}

# Set script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define settings file path
if ([string]::IsNullOrEmpty($SettingsFile)) {
    $SettingsFile = Join-Path $ScriptDir "script-launcher-settings.json"
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
}

# Load settings from file
function Load-Settings {
    <#
    .SYNOPSIS
        Loads settings from the settings file.
    
    .DESCRIPTION
        Reads and returns the settings from the specified settings file, or default settings if the file doesn't exist.
    
    .RETURNVALUE
        A hashtable containing the loaded settings.
    #>
    if (Test-Path $SettingsFile) {
        try {
            $loadedSettings = Get-Content -Path $SettingsFile -Raw -Encoding UTF8 | ConvertFrom-Json
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
        @{ Name = "test_script.ps1"; Path = "tree-sitter-cangjie/tests/test_verification/test_script.ps1"; Description = "Cangjie 语法验证测试脚本" }
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

# Function to display menu and get selection
function Get-MenuSelection {
    param(
        [string]$Title,
        [array]$Options
    )
    
    Clear-Host
    Write-Host "$Title" -ForegroundColor Green
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host
    
    for ($i = 0; $i -lt $Options.Count; $i++) {
        Write-Host "$($i+1). $($Options[$i])" -ForegroundColor Yellow
    }
    
    Write-Host "0. 退出" -ForegroundColor Red
    Write-Host
    
    do {
        $Selection = Read-Host "请输入选择 (0-$($Options.Count))"
        $Valid = [int]::TryParse($Selection, [ref]$null) -and $Selection -ge 0 -and $Selection -le $Options.Count
        if (-not $Valid) {
            Write-Host "无效选择，请重新输入。" -ForegroundColor Red
        }
    } while (-not $Valid)
    
    return [int]$Selection
}

# Function to display script details
function Show-ScriptDetails {
    param(
        [hashtable]$Script
    )
    
    Write-Host "\n脚本详情:" -ForegroundColor Cyan
    Write-Host "-" * 30 -ForegroundColor Cyan
    Write-Host "名称: $($Script.Name)" -ForegroundColor White
    Write-Host "路径: $($Script.Path)" -ForegroundColor Gray
    Write-Host "描述: $($Script.Description)" -ForegroundColor White
    Write-Host "完整路径: $(Join-Path $ScriptDir $Script.Path)" -ForegroundColor Gray
    Write-Host
}

# Function to display settings menu
function Show-SettingsMenu {
    Clear-Host
    Write-Host "脚本启动器设置" -ForegroundColor Green
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host
    
    $SettingsOptions = @(
        "执行策略: $($Settings.ExecutionPolicy)",
        "详细输出: $($Settings.Verbose)",
        "调试模式: $($Settings.Debug)",
        "错误处理: $($Settings.ErrorActionPreference)",
        "工作目录: $($Settings.WorkingDirectory)",
        "显示脚本输出: $($Settings.ShowScriptOutput)",
        "保存上次选择: $($Settings.SaveLastSelection)",
        "恢复默认设置",
        "保存设置",
        "返回主菜单"
    )
    
    do {
        for ($i = 0; $i -lt $SettingsOptions.Count; $i++) {
            Write-Host "$($i+1). $($SettingsOptions[$i])" -ForegroundColor Yellow
        }
        Write-Host
        $Selection = Read-Host "请输入选择 (1-$($SettingsOptions.Count))"
        $Valid = [int]::TryParse($Selection, [ref]$null) -and $Selection -ge 1 -and $Selection -le $SettingsOptions.Count
        if (-not $Valid) {
            Write-Host "无效选择，请重新输入。" -ForegroundColor Red
        }
    } while (-not $Valid)
    
    return [int]$Selection
}

# Main menu loop
while ($true) {
    # Display main menu with settings option
    $Categories = $ScriptCategories.Keys | Sort-Object
    $MainMenuOptions = @($Categories) + @("设置")
    $Selection = Get-MenuSelection -Title "Cangjie Extension 脚本启动器" -Options $MainMenuOptions
    
    if ($Selection -eq 0) {
        Write-Host "\n退出脚本启动器..." -ForegroundColor Green
        break
    }
    
    # Check if settings was selected
    if ($Selection -eq $MainMenuOptions.Count) {
        # Show settings menu
        while ($true) {
            $SettingsSelection = Show-SettingsMenu
            
            switch ($SettingsSelection) {
                1 {
                    # Change execution policy
                    $newPolicy = Read-Host "输入新的执行策略 (Restricted, AllSigned, RemoteSigned, Unrestricted)"
                    if ($newPolicy -in @("Restricted", "AllSigned", "RemoteSigned", "Unrestricted")) {
                        $Settings.ExecutionPolicy = $newPolicy
                    } else {
                        Write-Host "无效的执行策略。" -ForegroundColor Red
                    }
                }
                2 {
                    # Toggle verbose
                    $Settings.Verbose = -not $Settings.Verbose
                }
                3 {
                    # Toggle debug
                    $Settings.Debug = -not $Settings.Debug
                }
                4 {
                    # Change error action preference
                    $newErrorAction = Read-Host "输入新的错误处理策略 (Continue, Stop, SilentlyContinue, Ignore, Inquire)"
                    if ($newErrorAction -in @("Continue", "Stop", "SilentlyContinue", "Ignore", "Inquire")) {
                        $Settings.ErrorActionPreference = $newErrorAction
                    } else {
                        Write-Host "无效的错误处理策略。" -ForegroundColor Red
                    }
                }
                5 {
                    # Change working directory
                    $newDir = Read-Host "输入新的工作目录 (留空使用当前目录)"
                    if ($newDir -and (Test-Path $newDir -PathType Container)) {
                        $Settings.WorkingDirectory = $newDir
                    } else {
                        Write-Host "无效的目录路径。" -ForegroundColor Red
                    }
                }
                6 {
                    # Toggle show script output
                    $Settings.ShowScriptOutput = -not $Settings.ShowScriptOutput
                }
                7 {
                    # Toggle save last selection
                    $Settings.SaveLastSelection = -not $Settings.SaveLastSelection
                }
                8 {
                    # Restore default settings
                    $Settings = $DefaultSettings
                    Write-Host "已恢复默认设置。" -ForegroundColor Green
                }
                9 {
                    # Save settings
                    Save-Settings -Settings $Settings
                }
                10 {
                    # Return to main menu
                    break
                }
            }
        }
        continue
    }
    
    # Get selected category
    $SelectedCategory = $Categories[$Selection - 1]
    $Scripts = $ScriptCategories[$SelectedCategory]
    
    # Display scripts in selected category
    $ScriptOptions = $Scripts | ForEach-Object { "$($_.Name) - $($_.Description)" }
    $ScriptSelection = Get-MenuSelection -Title "$SelectedCategory" -Options $ScriptOptions
    
    if ($ScriptSelection -eq 0) {
        continue
    }
    
    # Get selected script
    $SelectedScript = $Scripts[$ScriptSelection - 1]
    $FullScriptPath = Join-Path $ScriptDir $SelectedScript.Path
    
    # Show script details
    Show-ScriptDetails -Script $SelectedScript
    
    # Confirm execution
    $Confirm = Read-Host "是否执行此脚本? (Y/N)"
    if ($Confirm -notmatch "^[Yy]$" -and $Confirm -ne "") {
        Write-Host "\n取消执行。" -ForegroundColor Yellow
        Read-Host "按 Enter 键继续..."
        continue
    }
    
    # Execute script in current terminal
    Write-Host "\n正在执行脚本: $($SelectedScript.Name)..." -ForegroundColor Green
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host
    
    try {
        # Run the script in the current terminal
        & "$FullScriptPath"
    } catch {
        Write-Host "\n脚本执行出错: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host
    Write-Host "=" * 50 -ForegroundColor Green
    Write-Host "脚本执行完成。" -ForegroundColor Green
    Read-Host "按 Enter 键继续..."
}

