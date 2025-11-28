#Requires -Version 7.0

# Script to update all PS1 files to require PowerShell 7

$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Where-Object { $_.Name -ne "update-ps1-scripts.ps1" }

foreach ($file in $ps1Files) {
    Write-Host "Updating $($file.Name)..."
    
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if the file already has a #Requires directive
    if ($content -notmatch '#Requires -Version') {
        # Add the #Requires directive at the beginning of the file
        $newContent = '#Requires -Version 7.0

' + $content
        Set-Content -Path $file.FullName -Value $newContent
        Write-Host "✓ Added PowerShell 7 requirement to $($file.Name)"
    } else {
        Write-Host "✓ $($file.Name) already has a #Requires directive"
    }
}

Write-Host "`nAll PS1 scripts updated to require PowerShell 7!"