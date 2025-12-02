<#
.SYNOPSIS
    PowerShell profile script for the Cangjie Extension project.

.DESCRIPTION
    This profile script ensures that PowerShell 7 is always used for project scripts.
    It sets up aliases, execution policies, and other environment configurations
    to provide a consistent PowerShell 7 environment for development and testing.

.EXAMPLE
    .\profile.ps1
    Loads the PowerShell 7 profile and configures the environment.

.NOTES
    This script requires PowerShell 7 or later.
    It should be loaded when starting a PowerShell session for Cangjie Extension development.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

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

# PowerShell profile to ensure PowerShell 7 is always used

# Alias powershell to pwsh to ensure PowerShell 7 is used
alias powershell='pwsh'

# Set default execution policy for convenience
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Write-Host "PowerShell 7 profile loaded. Using PowerShell version: $($PSVersionTable.PSVersion)"

