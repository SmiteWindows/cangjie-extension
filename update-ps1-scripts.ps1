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

# Script to update all PS1 files to require PowerShell 7

$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Where-Object { $_.Name -ne "update-ps1-scripts.ps1" }

foreach ($file in $ps1Files) {
    Write-Host "Updating $($file.Name)..."
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file already has a #Requires directive
    if ($content -notmatch '#Requires -Version') {
        # Add the #Requires directive at the beginning of the file
        $newContent = '# Ensure PowerShell 7 environment
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

' + $content
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "✓ Added PowerShell 7 requirement to $($file.Name)"
    } else {
        Write-Host "✓ $($file.Name) already has a #Requires directive"
    }
}

Write-Host "`nAll PS1 scripts updated to require PowerShell 7!"
