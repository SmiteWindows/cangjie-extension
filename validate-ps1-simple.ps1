<#
.SYNOPSIS
    Simple PowerShell script validation tool.

.DESCRIPTION
    This script provides a simple validation for PowerShell scripts (.ps1 files).
    It checks for file existence, content, PowerShell 7 environment configuration, and basic syntax.
    The script processes all PS1 files in the specified directory and subdirectories.

.PARAMETER Path
    The root directory to search for PS1 scripts. Defaults to the current directory.

.PARAMETER Recurse
    If specified, searches for PS1 scripts recursively in all subdirectories. Defaults to $true.

.PARAMETER ExcludeNodeModules
    If specified, excludes scripts in node_modules directories. Defaults to $true.

.PARAMETER Quiet
    If specified, displays only errors and summary information, omitting successful validations.

.EXAMPLE
    .\validate-ps1-simple.ps1
    Validates all PS1 scripts in the current directory and subdirectories.

.EXAMPLE
    .\validate-ps1-simple.ps1 -Path "C:\MyScripts" -Recurse:$false
    Validates PS1 scripts only in the specified directory, not recursively.

.EXAMPLE
    .\validate-ps1-simple.ps1 -ExcludeNodeModules:$false
    Validates all PS1 scripts including those in node_modules directories.

.EXAMPLE
    .\validate-ps1-simple.ps1 -Quiet
    Validates scripts with minimal output, showing only errors and summary.

.NOTES
    This script requires PowerShell 7 or later.
    It uses basic syntax validation with [ScriptBlock]::Create().
    It excludes node_modules directories by default for performance and relevance.
    The script provides a simple validation summary at the end.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$Path = ".",
    [switch]$Recurse = $true,
    [switch]$ExcludeNodeModules = $true,
    [switch]$Quiet = $false
)

# Ensure PowerShell 7 environment
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7 or later. Attempting to switch to PowerShell 7..." -ForegroundColor Yellow
    
    # Check if pwsh is available
    if (Get-Command pwsh -ErrorAction SilentlyContinue) {
        # Restart the script in PowerShell 7
        pwsh -File $PSCommandPath @args
        exit $LASTEXITCODE
    } else {
        Write-Host "PowerShell 7 (pwsh) is not installed. Please install PowerShell 7 and try again." -ForegroundColor Red
        exit 1
    }
}

# Get all PS1 files, sorted by name
$ps1Files = Get-ChildItem -Path $Path -Filter "*.ps1" -Recurse:$Recurse | Sort-Object Name

# Exclude node_modules if requested
if ($ExcludeNodeModules) {
    $ps1Files = $ps1Files | Where-Object { $_.FullName -notlike "*node_modules*" }
}

Write-Host "Validating PS1 scripts..." -ForegroundColor Green
Write-Host "Path: $Path" -ForegroundColor Cyan
Write-Host "Recurse: $Recurse" -ForegroundColor Cyan
Write-Host "Exclude node_modules: $ExcludeNodeModules" -ForegroundColor Cyan
Write-Host "Total files found: $($ps1Files.Count)" -ForegroundColor Cyan
Write-Host "=" * 80

# Statistics counters
$processedCount = 0
$validCount = 0
$invalidCount = 0
$emptyCount = 0
$notFoundCount = 0

foreach ($file in $ps1Files) {
    $processedCount++
    $fileValid = $true
    
    if (-not $Quiet) {
        Write-Host "File: $($file.Name)" -ForegroundColor Yellow
    }
    
    # Check if file exists and has content
    if (-not (Test-Path -Path $file.FullName -PathType Leaf)) {
        Write-Host "  - File does not exist or is not a file" -ForegroundColor Red
        $notFoundCount++
        $invalidCount++
        $fileValid = $false
        continue
    }
    
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    if ([string]::IsNullOrEmpty($content)) {
        Write-Host "  - File is empty" -ForegroundColor Yellow
        $emptyCount++
        $invalidCount++
        $fileValid = $false
        continue
    }
    
    # Check for PowerShell 7 environment configuration
    $hasPwsh7Config = $content -match 'Ensure PowerShell 7 environment' -or $content -match '#Requires\s+-Version\s+7\.0'
    if ($hasPwsh7Config) {
        if (-not $Quiet) {
            Write-Host "  - PowerShell 7 config: ✓" -ForegroundColor Green
        }
    } else {
        Write-Host "  - PowerShell 7 config: ✗" -ForegroundColor Red
        $fileValid = $false
    }
    
    # Check basic syntax
    try {
        $null = [ScriptBlock]::Create($content)
        if (-not $Quiet) {
            Write-Host "  - Basic syntax: ✓" -ForegroundColor Green
        }
    } catch {
        Write-Host "  - Basic syntax: ✗" -ForegroundColor Red
        Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor DarkRed
        $fileValid = $false
    }
    
    if ($fileValid) {
        $validCount++
    } else {
        $invalidCount++
    }
    
    if (-not $Quiet) {
        Write-Host
    }
}

Write-Host "=" * 80
Write-Host "Validation Summary:" -ForegroundColor Cyan
Write-Host "Files processed: $processedCount" -ForegroundColor Cyan
Write-Host "Valid files: $validCount" -ForegroundColor Green
Write-Host "Invalid files: $invalidCount" -ForegroundColor Red
Write-Host "Empty files: $emptyCount" -ForegroundColor Yellow
Write-Host "Files not found: $notFoundCount" -ForegroundColor Orange
Write-Host "=" * 80
Write-Host "Validation completed." -ForegroundColor Green

