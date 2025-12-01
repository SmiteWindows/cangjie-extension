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

# Simple script to validate project PS1 files only

# Define project root directory (relative to script location)
$scriptPath = $PSScriptRoot
$projectRoot = $scriptPath

# Define project PS1 files to validate
$projectPs1Files = @(
    "setup-cangjie-sdk.ps1",
    "setup-wasi-sdk.ps1",
    "tree-sitter-tools.ps1",
    "update-dependencies.ps1",
    "update-ps1-scripts.ps1",
    "validate-ps1-simple.ps1",
    "bump-version.ps1",
    "generate-changelog.ps1",
    "profile.ps1"
)

Write-Host "Validating project PS1 scripts..." -ForegroundColor Green
Write-Host "=" * 80

$validCount = 0
$invalidCount = 0

foreach ($fileName in $projectPs1Files) {
    $filePath = Join-Path -Path $projectRoot -ChildPath $fileName
    
    Write-Host "File: $fileName"
    
    # Check if file exists and has content
    if (-not (Test-Path -Path $filePath -PathType Leaf)) {
        Write-Host "  - File does not exist or is not a file" -ForegroundColor Red
        $invalidCount++
        continue
    }
    
    $content = Get-Content -Path $filePath -Raw
    if ([string]::IsNullOrEmpty($content)) {
        Write-Host "  - File is empty" -ForegroundColor Yellow
        $invalidCount++
        continue
    }
    
    $fileValid = $true
    
    # Check for # Ensure PowerShell 7 environment
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
    if ($content -match '#Requires -Version\s+7\.0') {
        Write-Host "  - Has # Ensure PowerShell 7 environment
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
}: ✓" -ForegroundColor Green
    } else {
        Write-Host "  - Has # Ensure PowerShell 7 environment
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
}: ✗" -ForegroundColor Red
        $fileValid = $false
    }
    
    # Check basic syntax
    try {
        $null = [ScriptBlock]::Create($content)
        Write-Host "  - Basic syntax: ✓" -ForegroundColor Green
    } catch {
        Write-Host "  - Basic syntax: ✗" -ForegroundColor Red
        Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
        $fileValid = $false
    }
    
    if ($fileValid) {
        $validCount++
    } else {
        $invalidCount++
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

