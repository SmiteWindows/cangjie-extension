#Requires -Version 7.0
# PowerShell profile to ensure PowerShell 7 is always used

# Alias powershell to pwsh to ensure PowerShell 7 is used
alias powershell='pwsh'

# Set default execution policy for convenience
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force

Write-Host "PowerShell 7 profile loaded. Using PowerShell version: $($PSVersionTable.PSVersion)"