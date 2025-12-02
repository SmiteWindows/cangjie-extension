<#
.SYNOPSIS
    Adds PowerShell 7 environment configuration to all PS1 scripts in the project.

.DESCRIPTION
    This script processes all PowerShell scripts in the project directory (excluding node_modules)
    and adds a PowerShell 7 environment check and auto-switching mechanism. The configuration ensures that:
    - Scripts check if they're running in PowerShell 7+
    - If not, they attempt to automatically switch to PowerShell 7 (pwsh)
    - If PowerShell 7 is not available, they show a helpful error message
    - The script preserves any existing comments at the beginning of files

.EXAMPLE
    .\add-pwsh7-config.ps1
    Processes all PS1 scripts in the project directory.

.NOTES
    Author: Cangjie Extension Team
    Version: 1.0
    Date: $(Get-Date)
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Get all PS1 files excluding node_modules directory
$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Where-Object { $_.FullName -notlike "*node_modules*" }

# Define the PowerShell 7 environment configuration to add to scripts
$pwsh7Config = @'
# Ensure PowerShell 7 environment
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7 or later. Attempting to switch to PowerShell 7..." -ForegroundColor Yellow
    
    # Check if pwsh executable is available in PATH
    if (Get-Command pwsh -ErrorAction SilentlyContinue) {
        # Restart the script in PowerShell 7 with the same arguments
        pwsh -File $PSCommandPath @args
        exit $LASTEXITCODE
    } else {
        # Show error message if PowerShell 7 is not installed
        Write-Host "PowerShell 7 (pwsh) is not installed. Please install PowerShell 7 and try again." -ForegroundColor Red
        exit 1
    }
}
'@

Write-Host "Adding PWSH7 environment configuration to $($ps1Files.Count) scripts..." -ForegroundColor Cyan

# Process each PS1 file
foreach ($file in $ps1Files) {
    Write-Host "Processing: $($file.FullName)" -ForegroundColor Yellow
    
    # Read the entire file content as a single string
    $content = Get-Content -Encoding UTF8 $file.FullName -Raw
    
    # Skip files that already have the PowerShell 7 configuration
    if ($content -match 'Ensure PowerShell 7 environment') {
        Write-Host "  ✓ Already has PWSH7 configuration" -ForegroundColor Green
        continue
    }
    
    if ($content -match '#Requires -Version\s+7\.0') {
        # Replace the simple #Requires statement with the full PowerShell 7 configuration
        $content = $content -replace '#Requires -Version\s+7\.0', $pwsh7Config
        Write-Host "  ✓ Replaced #Requires with PWSH7 configuration" -ForegroundColor Green
    } else {
        # Split content into lines for precise insertion
        $lines = $content -split "`r?`n"
        $insertIndex = 0
        
        # Find the first non-comment line in the file
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -notmatch '^\s*#') {
                $insertIndex = $i
                break
            }
        }
        
        # Insert the PowerShell 7 configuration at the found position
        $lines = $lines[0..($insertIndex-1)] + @($pwsh7Config -split "`r?`n") + $lines[$insertIndex..($lines.Count-1)]
        $content = $lines -join "`r`n"
        Write-Host "  ✓ Added PWSH7 configuration" -ForegroundColor Green
    }
    
    # Save the modified content back to the file with UTF8 encoding
    Set-Content -Encoding UTF8 $file.FullName -Value $content
}

Write-Host "`n✅ All scripts processed!" -ForegroundColor Green

