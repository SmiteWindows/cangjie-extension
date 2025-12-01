# Simple script to validate PS1 files

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

$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Sort-Object Name

Write-Host "Validating PS1 scripts..."
Write-Host "=" * 80

foreach ($file in $ps1Files) {
    Write-Host "File: $($file.Name)"
    
    # Check if file exists and has content
    if (-not (Test-Path -Path $file.FullName -PathType Leaf)) {
        Write-Host "  - File does not exist or is not a file" -ForegroundColor Red
        continue
    }
    
    $content = Get-Content -Path $file.FullName -Raw
    if ([string]::IsNullOrEmpty($content)) {
        Write-Host "  - File is empty" -ForegroundColor Yellow
        continue
    }
    
    # Check for PowerShell 7 environment configuration
    if ($content -match 'Ensure PowerShell 7 environment') {
        Write-Host "  - Has PowerShell 7 environment config: ✓" -ForegroundColor Green
    } else {
        Write-Host "  - Has PowerShell 7 environment config: ✗" -ForegroundColor Red
    }
    
    # Check basic syntax
    try {
        $null = [ScriptBlock]::Create($content)
        Write-Host "  - Basic syntax: ✓" -ForegroundColor Green
    } catch {
        Write-Host "  - Basic syntax: ✗" -ForegroundColor Red
        Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host
}

Write-Host "=" * 80
Write-Host "Validation completed."