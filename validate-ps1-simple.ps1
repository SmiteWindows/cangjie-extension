# Simple script to validate PS1 files

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
    
    # Check for #Requires -Version 7.0
    if ($content -match '#Requires -Version\s+7\.0') {
        Write-Host "  - Has #Requires -Version 7.0: ✓" -ForegroundColor Green
    } else {
        Write-Host "  - Has #Requires -Version 7.0: ✗" -ForegroundColor Red
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