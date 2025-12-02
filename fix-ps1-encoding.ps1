<#
.SYNOPSIS
    Fixes PS1 scripts encoding for proper Chinese character display.

.DESCRIPTION
    This script ensures all PS1 scripts use UTF-8 encoding and adds explicit UTF-8 encoding parameters to file operations.
    It processes all PS1 files in the project, excluding node_modules directories.

.PARAMETER Path
    The root directory to search for PS1 scripts. Defaults to the script's directory.

.PARAMETER Recurse
    If specified, searches for PS1 scripts recursively in subdirectories. Defaults to $true.

.EXAMPLE
    .\fix-ps1-encoding.ps1
    Fixes encoding for all PS1 scripts in the current project.

.EXAMPLE
    .\fix-ps1-encoding.ps1 -Path "C:\MyScripts" -Recurse:$false
    Fixes encoding for PS1 scripts in the specified directory without recursion.

.NOTES
    This script requires PowerShell 7 or later.
    It updates file operations to explicitly use UTF-8 encoding for proper Chinese character handling.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$Path = $PSScriptRoot,
    [switch]$Recurse = $true
)

# Get all PS1 scripts except those in node_modules
$ps1Scripts = Get-ChildItem -Path "$Path" -Filter "*.ps1" -Recurse:$Recurse | 
    Where-Object { $_.FullName -notlike "*node_modules*" }

Write-Host "Found $($ps1Scripts.Count) PS1 scripts to fix." -ForegroundColor Green

foreach ($script in $ps1Scripts) {
    Write-Host "Processing $($script.FullName)..." -ForegroundColor Yellow
    
    try {
        # Read the script content with UTF8 encoding
        $content = Get-Content -Path $script.FullName -Raw -Encoding UTF8
        
        # Fix Get-Content to use UTF8 encoding explicitly
        $content = $content -replace "Get-Content\s+(\S+)(?!\s+-Encoding\s+UTF8)\s*(\|\s*)?", "Get-Content -Path $1 -Encoding UTF8 $2"
        
        # Fix Out-File to use UTF8 encoding explicitly
        $content = $content -replace "Out-File\s+(\S+)(?!\s+-Encoding\s+UTF8)\s*(\|\s*)?", "Out-File -FilePath $1 -Encoding UTF8 $2"
        
        # Fix Set-Content to use UTF8 encoding explicitly
        $content = $content -replace "Set-Content\s+(\S+)(?!\s+-Encoding\s+UTF8)\s*(\|\s*)?", "Set-Content -Path $1 -Encoding UTF8 $2"
        
        # Fix Add-Content to use UTF8 encoding explicitly
        $content = $content -replace "Add-Content\s+(\S+)(?!\s+-Encoding\s+UTF8)\s*(\|\s*)?", "Add-Content -Path $1 -Encoding UTF8 $2"
        
        # Write the updated content back with UTF8 encoding
        $content | Out-File -FilePath $script.FullName -Encoding UTF8
        
        Write-Host "✓ Fixed encoding for $($script.FullName)." -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to process $($script.FullName): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nAll PS1 scripts have been processed for proper Chinese character display." -ForegroundColor Green

