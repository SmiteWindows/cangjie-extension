# Script to add PWSH7 environment configuration to all ps1 scripts

# Get all ps1 files excluding node_modules
$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Where-Object { $_.FullName -notlike "*node_modules*" }

# PWSH7 environment configuration
$pwsh7Config = @'
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
'@

Write-Host "Adding PWSH7 environment configuration to $($ps1Files.Count) scripts..." -ForegroundColor Cyan

foreach ($file in $ps1Files) {
    Write-Host "Processing: $($file.FullName)" -ForegroundColor Yellow
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if already has the configuration
    if ($content -match 'Ensure PowerShell 7 environment') {
        Write-Host "  ✓ Already has PWSH7 configuration" -ForegroundColor Green
        continue
    }
    
    # Replace #Requires -Version 7.0 if present
    if ($content -match '#Requires -Version\s+7\.0') {
        $content = $content -replace '#Requires -Version\s+7\.0', $pwsh7Config
        Write-Host "  ✓ Replaced #Requires with PWSH7 configuration" -ForegroundColor Green
    } else {
        # Add configuration at the beginning of the file, after any existing comments
        $lines = $content -split "`r?`n"
        $insertIndex = 0
        
        # Find the first non-comment line
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -notmatch '^\s*#') {
                $insertIndex = $i
                break
            }
        }
        
        # Insert configuration
        $lines = $lines[0..($insertIndex-1)] + @($pwsh7Config -split "`r?`n") + $lines[$insertIndex..($lines.Count-1)]
        $content = $lines -join "`r`n"
        Write-Host "  ✓ Added PWSH7 configuration" -ForegroundColor Green
    }
    
    # Save the modified content
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "`n✅ All scripts processed!" -ForegroundColor Green
