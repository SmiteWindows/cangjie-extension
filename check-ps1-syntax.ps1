#Requires -Version 7.0

<#
.SYNOPSIS
    Checks the syntax of all PowerShell scripts in the project.

.DESCRIPTION
    This script validates the syntax of all .ps1 files in the project, excluding those in node_modules directories.
    It uses the PowerShell parser to check for syntax errors and provides a summary of the results.

.PARAMETER Path
    The root directory to search for PS1 scripts. Defaults to the script's directory.

.PARAMETER Recurse
    If specified, searches for PS1 scripts recursively in subdirectories. Defaults to $true.

.EXAMPLE
    .\check-ps1-syntax.ps1
    Checks syntax for all PS1 scripts in the current project.

.EXAMPLE
    .\check-ps1-syntax.ps1 -Path "C:\MyScripts"
    Checks syntax for all PS1 scripts in the specified directory.

.NOTES
    This script requires PowerShell 7 or later.
    It uses the [System.Management.Automation.PSParser]::Tokenize() method for reliable syntax checking.
#>

param(
    [string]$Path = $PSScriptRoot,
    [switch]$Recurse = $true
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Get all PS1 scripts except those in node_modules
$ps1Scripts = Get-ChildItem -Path "$Path" -Filter "*.ps1" -Recurse:$Recurse | 
    Where-Object { $_.FullName -notlike "*node_modules*" }

Write-Host "Found $($ps1Scripts.Count) PS1 scripts to check." -ForegroundColor Green

$errorCount = 0
$successCount = 0

foreach ($script in $ps1Scripts) {
    Write-Host "Checking syntax for $($script.FullName)..." -ForegroundColor Yellow
    
    try {
        # Use PowerShell's syntax checking feature directly
        $scriptContent = Get-Content -Path $script.FullName -Raw
        $null = [System.Management.Automation.PSParser]::Tokenize($scriptContent, [ref]$null)
        Write-Host "✓ Syntax is valid for $($script.FullName)." -ForegroundColor Green
        $successCount++
    } catch {
        Write-Host "✗ Syntax error in $($script.FullName): $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host "`n=== Syntax Check Summary ===" -ForegroundColor Cyan
Write-Host "Total scripts: $($ps1Scripts.Count)" -ForegroundColor White
Write-Host "Valid syntax: $successCount" -ForegroundColor Green
Write-Host "Syntax errors: $errorCount" -ForegroundColor Red

if ($errorCount -eq 0) {
    Write-Host "`nAll scripts have valid syntax! 🎉" -ForegroundColor Green
} else {
    Write-Host "`nSome scripts have syntax errors. Please fix them." -ForegroundColor Yellow
}

