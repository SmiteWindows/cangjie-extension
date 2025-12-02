<#
.SYNOPSIS
    Validates project-specific PowerShell scripts.

.DESCRIPTION
    This script validates a predefined set of PowerShell scripts in the project.
    It checks for file existence, content, PowerShell 7 compatibility, and basic syntax.
    The script ensures that all project scripts meet quality and compatibility standards.

.PARAMETER ProjectRoot
    The root directory of the project. Defaults to the script's directory.

.PARAMETER Scripts
    An array of script filenames to validate. If not specified, uses the default project scripts.

.PARAMETER Verbose
    If specified, enables verbose output with detailed validation information.

.EXAMPLE
    .\validate-project-ps1.ps1
    Validates all default project PowerShell scripts.

.EXAMPLE
    .\validate-project-ps1.ps1 -ProjectRoot "C:\MyProject"
    Validates scripts in the specified project directory.

.EXAMPLE
    .\validate-project-ps1.ps1 -Scripts @("setup-cangjie-sdk.ps1", "tree-sitter-tools.ps1")
    Validates only the specified scripts.

.EXAMPLE
    .\validate-project-ps1.ps1 -Verbose
    Validates scripts with detailed verbose output.

.NOTES
    This script requires PowerShell 7 or later.
    It uses a predefined list of project scripts by default.
    The validation includes checks for PowerShell 7 compatibility and basic syntax.
    It provides a summary report of valid and invalid scripts.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$ProjectRoot = $PSScriptRoot,
    [array]$Scripts,
    [switch]$Verbose = $false
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

# Define default project PS1 files to validate
$defaultProjectPs1Files = @(
    "setup-cangjie-sdk.ps1",
    "setup-wasi-sdk.ps1",
    "tree-sitter-tools.ps1",
    "update-dependencies.ps1",
    "update-ps1-scripts.ps1",
    "validate-ps1-simple.ps1",
    "bump-version.ps1",
    "generate-changelog.ps1",
    "profile.ps1",
    "build-test-all.ps1",
    "check-ps1-syntax.ps1",
    "fix-ps1-encoding.ps1",
    "gui-script-launcher.ps1",
    "script-launcher.ps1",
    "test-launcher.ps1",
    "test-wasm-module.ps1",
    "update-ps1-best-practices.ps1"
)

# Use provided scripts or default list
$projectPs1Files = if ($Scripts) { $Scripts } else { $defaultProjectPs1Files }

Write-Host "Validating project PS1 scripts..." -ForegroundColor Green
Write-Host "=" * 80
Write-Host "Project Root: $ProjectRoot" -ForegroundColor Cyan
Write-Host "Scripts to validate: $($projectPs1Files.Count)" -ForegroundColor Cyan
Write-Host "=" * 80

$validCount = 0
$invalidCount = 0

foreach ($fileName in $projectPs1Files) {
    $filePath = Join-Path -Path $ProjectRoot -ChildPath $fileName
    
    Write-Host "File: $fileName" -ForegroundColor Yellow
    
    # Check if file exists and has content
    if (-not (Test-Path -Path $filePath -PathType Leaf)) {
        Write-Host "  - File does not exist or is not a file" -ForegroundColor Red
        $invalidCount++
        Write-Host
        continue
    }
    
    $content = Get-Content -Path $filePath -Raw -Encoding UTF8
    if ([string]::IsNullOrEmpty($content)) {
        Write-Host "  - File is empty" -ForegroundColor Yellow
        $invalidCount++
        Write-Host
        continue
    }
    
    $fileValid = $true
    
    # Check for PowerShell 7 compatibility (either #Requires or environment check)
    $hasRequiresDirective = $content -match '#Requires\s+-Version\s+7\.0'
    $hasEnvironmentCheck = $content -match 'PSVersionTable\.PSVersion\.Major\s+-lt\s+7'
    
    if ($hasRequiresDirective -or $hasEnvironmentCheck) {
        Write-Host "  - PowerShell 7 compatibility: ✓" -ForegroundColor Green
        if ($Verbose) {
            if ($hasRequiresDirective) {
                Write-Host "    - Has #Requires -Version 7.0 directive" -ForegroundColor DarkGreen
            } else {
                Write-Host "    - Has PowerShell 7 environment check" -ForegroundColor DarkGreen
            }
        }
    } else {
        Write-Host "  - PowerShell 7 compatibility: ✗" -ForegroundColor Red
        Write-Host "    - Missing #Requires -Version 7.0 or PowerShell 7 environment check" -ForegroundColor DarkRed
        $fileValid = $false
    }
    
    # Check basic syntax using PSParser for better accuracy
    try {
        $null = [System.Management.Automation.PSParser]::Tokenize($content, [ref]$null)
        Write-Host "  - Basic syntax: ✓" -ForegroundColor Green
        if ($Verbose) {
            Write-Host "    - No syntax errors detected" -ForegroundColor DarkGreen
        }
    } catch {
        Write-Host "  - Basic syntax: ✗" -ForegroundColor Red
        Write-Host "    - Error: $($_.Exception.Message)" -ForegroundColor DarkRed
        $fileValid = $false
    }
    
    # Check for proper error preference setting
    $hasErrorPreference = $content -match '\$ErrorActionPreference\s*='
    if ($hasErrorPreference) {
        Write-Host "  - Error preference setting: ✓" -ForegroundColor Green
        if ($Verbose) {
            Write-Host "    - Has $ErrorActionPreference setting" -ForegroundColor DarkGreen
        }
    } else {
        Write-Host "  - Error preference setting: ✗" -ForegroundColor Red
        Write-Host "    - Missing $ErrorActionPreference setting" -ForegroundColor DarkRed
        $fileValid = $false
    }
    
    # Check for strict mode setting
    $hasStrictMode = $content -match 'Set-StrictMode\s+-Version'
    if ($hasStrictMode) {
        Write-Host "  - Strict mode setting: ✓" -ForegroundColor Green
        if ($Verbose) {
            Write-Host "    - Has Set-StrictMode declaration" -ForegroundColor DarkGreen
        }
    } else {
        Write-Host "  - Strict mode setting: ✗" -ForegroundColor Red
        Write-Host "    - Missing Set-StrictMode declaration" -ForegroundColor DarkRed
        $fileValid = $false
    }
    
    # Update counters
    if ($fileValid) {
        $validCount++
        if ($Verbose) {
            Write-Host "  - Status: VALID" -ForegroundColor Green
        }
    } else {
        $invalidCount++
        if ($Verbose) {
            Write-Host "  - Status: INVALID" -ForegroundColor Red
        }
    }
    
    Write-Host
}

Write-Host "=" * 80
Write-Host "Validation Summary:" -ForegroundColor Cyan
Write-Host "Total files: $($projectPs1Files.Count)" -ForegroundColor Cyan
Write-Host "Valid files: $validCount" -ForegroundColor Green
Write-Host "Invalid files: $invalidCount" -ForegroundColor Red
Write-Host "=" * 80
Write-Host "Validation completed." -ForegroundColor Green


