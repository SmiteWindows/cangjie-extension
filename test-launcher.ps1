<#
.SYNOPSIS
    Test script for validating script launcher functionality.

.DESCRIPTION
    This script serves as a test utility to verify that the script launcher
    is working correctly. It displays system information and confirms that
    PowerShell 7 is being used.

.PARAMETER Message
    Optional custom message to display instead of the default "测试脚本启动器成功!".

.PARAMETER NoPause
    If specified, the script exits immediately without waiting for user input.

.EXAMPLE
    .\test-launcher.ps1
    Displays the default success message and system information, then waits for user input.

.EXAMPLE
    .\test-launcher.ps1 -Message "自定义测试消息"
    Displays a custom message and system information.

.EXAMPLE
    .\test-launcher.ps1 -NoPause
    Displays the default message and exits immediately without waiting.

.NOTES
    This script requires PowerShell 7 or later.
    It is used to validate that script launchers (both CLI and GUI) are functioning properly.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$Message = "测试脚本启动器成功!",
    [switch]$NoPause
)

Write-Host $Message -ForegroundColor Green
Write-Host "当前脚本路径: $PSCommandPath" -ForegroundColor Yellow
Write-Host "PowerShell 版本: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
Write-Host "当前工作目录: $PWD" -ForegroundColor Magenta

# 等待用户输入（如果未指定-NoPause）
if (-not $NoPause) {
    Read-Host "按 Enter 键退出..."
}

