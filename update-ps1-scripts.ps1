<#
.SYNOPSIS
    Updates all PowerShell scripts to require PowerShell 7.

.DESCRIPTION
    This script ensures that all PowerShell scripts in the project require PowerShell 7 or later.
    It adds a PowerShell 7 environment check to scripts that don't already have a #Requires directive.
    The environment check automatically attempts to restart scripts in PowerShell 7 if they're run in an older version.

.PARAMETER Path
    The root directory to search for PS1 scripts. Defaults to the current directory.

.PARAMETER Recurse
    If specified, searches for PS1 scripts recursively in all subdirectories. Defaults to $true.

.PARAMETER ExcludeFile
    File names to exclude from processing. Defaults to the script itself.

.EXAMPLE
    .\update-ps1-scripts.ps1
    Updates all PS1 scripts in the current directory and subdirectories.

.EXAMPLE
    .\update-ps1-scripts.ps1 -Path "C:\MyScripts" -Recurse:$false
    Updates PS1 scripts only in the specified directory, not recursively.

.EXAMPLE
    .\update-ps1-scripts.ps1 -ExcludeFile "test-script.ps1"
    Updates all PS1 scripts except test-script.ps1.

.NOTES
    This script requires PowerShell 7 or later.
    It processes all PS1 files except itself by default.
    It adds a comprehensive PowerShell 7 environment check to scripts.
    The script uses UTF8 encoding for all file operations.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$Path = ".",
    [switch]$Recurse = $true,
    [array]$ExcludeFile = @("update-ps1-scripts.ps1")
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

Write-Host "🚀 Starting PowerShell 7 requirement update..." -ForegroundColor Green
Write-Host ""

# Get all PS1 files
$ps1Files = Get-ChildItem -Path $Path -Filter "*.ps1" -Recurse:$Recurse | 
    Where-Object { $ExcludeFile -notcontains $_.Name -and $_.FullName -notlike "*node_modules*" }

Write-Host "📋 Found $($ps1Files.Count) PS1 scripts to process." -ForegroundColor Cyan
Write-Host ""

# Counter for updated files
$updatedCount = 0
$skippedCount = 0

foreach ($file in $ps1Files) {
    Write-Host "🔧 Processing: $($file.FullName)" -ForegroundColor Yellow
    
    try {
        # Read file content with UTF8 encoding
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Check if the file already has a #Requires directive or PowerShell 7 environment check
        if ($content -notmatch '#Requires -Version' -and $content -notmatch 'PSVersionTable\.PSVersion\.Major -lt 7') {
            # PowerShell 7 environment check content
            $pwsh7Check = '# Ensure PowerShell 7 environment
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

'
            
            # Add the PowerShell 7 environment check at the beginning of the file
            $newContent = $pwsh7Check + $content
            
            # Write the updated content back to the file with UTF8 encoding
            Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
            
            Write-Host "✅ Added PowerShell 7 requirement to $($file.Name)" -ForegroundColor Green
            $updatedCount++
        } else {
            Write-Host "✓ $($file.Name) already has PowerShell 7 support" -ForegroundColor Gray
            $skippedCount++
        }
    } catch {
        Write-Host "❌ Error updating $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Show summary
Write-Host "📊 Update Summary:" -ForegroundColor Cyan
Write-Host "   Total scripts: $($ps1Files.Count)" -ForegroundColor Cyan
Write-Host "   Updated scripts: $updatedCount" -ForegroundColor Green
Write-Host "   Skipped scripts: $skippedCount" -ForegroundColor Gray
Write-Host ""

Write-Host "🎉 PowerShell 7 requirement update completed!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Notes:"
Write-Host "   - Scripts now automatically check for PowerShell 7" -ForegroundColor Yellow
Write-Host "   - They'll attempt to restart in PowerShell 7 if needed" -ForegroundColor Yellow
Write-Host "   - UTF8 encoding is used for all file operations" -ForegroundColor Yellow

