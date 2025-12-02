#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Testing validate-ps1-simple.ps1..."

$validationScript = "D:\新建文件夹\qianwenai\cangjie-extension\validate-ps1-simple.ps1"

if (Test-Path $validationScript) {
    Write-Host "Script exists: $validationScript"
    
    try {
        # Run the validation script with minimal output
        & $validationScript -Quiet
        Write-Host "Validation script ran successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Error running validation script: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Error Details: $($_.ScriptStackTrace)" -ForegroundColor DarkRed
    }
} else {
    Write-Host "Script not found: $validationScript" -ForegroundColor Red
}
