<#
.SYNOPSIS
    Configures the WASI SDK environment for the Cangjie Extension.

.DESCRIPTION
    This script sets up the WASI_SDK_PATH environment variable required for building
    WebAssembly (WASM) components for the Cangjie Extension. It validates the provided
    WASI SDK directory and configures the environment variable with the specified scope.

.PARAMETER WasiSdkPath
    The path to the extracted WASI SDK directory (e.g., "C:\Users\username\Downloads\wasi-sdk-29.0").
    If not provided, the script will prompt for this information.

.PARAMETER Scope
    The scope for the environment variable. Valid values are "User" (default) or "Machine".
    "User" sets the variable for the current user only.
    "Machine" sets the variable system-wide and requires administrator privileges.

.PARAMETER Help
    If specified, displays this help information and exits.

.EXAMPLE
    .\setup-wasi-sdk.ps1 -WasiSdkPath "C:\Users\username\Downloads\wasi-sdk-29.0"
    Configures the WASI SDK with the specified path for the current user.

.EXAMPLE
    .\setup-wasi-sdk.ps1 -WasiSdkPath "D:\wasi-sdk-29.0" -Scope Machine
    Configures the WASI SDK system-wide with the specified path.

.EXAMPLE
    .\setup-wasi-sdk.ps1 -Help
    Displays help information.

.NOTES
    This script requires PowerShell 7 or later.
    Administrator privileges are required for system-wide (Machine) configuration.
    The script validates the WASI SDK directory by checking for expected files.
    It sets the WASI_SDK_PATH environment variable both for the current session and permanently.
    The WASI SDK is required for building WebAssembly components for the Cangjie Extension.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$WasiSdkPath,
    [string]$Scope = "User",
    [switch]$Help = $false
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

# Function to show help information
function Show-Help {
    Write-Host "Setup WASI SDK Script for Cangjie Extension"
    Write-Host ""
    Write-Host "Usage: .\setup-wasi-sdk.ps1 [-WasiSdkPath <path>] [-Scope <scope>] [-Help]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -WasiSdkPath <path>  - Path to the extracted WASI SDK directory (e.g., C:\Users\username\Downloads\wasi-sdk-29.0)"
    Write-Host "  -Scope <scope>       - Environment variable scope (User or Machine), default: User"
    Write-Host "  -Help               - Show this help information"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\setup-wasi-sdk.ps1 -WasiSdkPath "C:\Users\username\Downloads\wasi-sdk-29.0""
    Write-Host "  .\setup-wasi-sdk.ps1 -WasiSdkPath "C:\Users\username\Downloads\wasi-sdk-29.0" -Scope Machine"
    Write-Host "  .\setup-wasi-sdk.ps1 -Help"
}

# Function to check if WASI SDK is already configured
function Test-WasiSdkConfigured {
    param(
        [string]$Path,
        [string]$Scope = "User"
    )
    
    Write-Host "🔍 Checking if WASI SDK is already configured..." -ForegroundColor Cyan
    
    # Check if WASI_SDK_PATH environment variable is set
    $currentWasiSdkPath = [Environment]::GetEnvironmentVariable("WASI_SDK_PATH", $Scope)
    if (-not [string]::IsNullOrEmpty($currentWasiSdkPath)) {
        Write-Host "✅ WASI_SDK_PATH environment variable is already set: $currentWasiSdkPath" -ForegroundColor Green
        
        # Validate the existing path
        if (Validate-WasiSdkDirectory -Path $currentWasiSdkPath) {
            Write-Host "✅ Existing WASI SDK directory is valid" -ForegroundColor Green
            return $true
        } else {
            Write-Host "⚠️  Existing WASI_SDK_PATH points to an invalid directory" -ForegroundColor Yellow
            return $false
        }
    }
    
    # Check if path parameter is provided and valid
    if (-not [string]::IsNullOrEmpty($Path)) {
        if (Validate-WasiSdkDirectory -Path $Path) {
            Write-Host "ℹ️  WASI SDK directory provided and valid, but not yet configured" -ForegroundColor Cyan
            return $false
        }
    }
    
    Write-Host "ℹ️  WASI SDK not configured" -ForegroundColor Cyan
    return $false
}

# Function to get system architecture
function Get-SystemArchitecture {
    <#
    .SYNOPSIS
        Gets the system architecture in a standardized format.
    .OUTPUTS
        [string] System architecture (x86_64, aarch64, etc.).
    #>
    $arch = $env:PROCESSOR_ARCHITECTURE
    switch ($arch) {
        "AMD64" { return "x86_64" }
        "ARM64" { return "aarch64" }
        "x86" { return "i686" }
        default { return $arch }
    }
}

# Function to validate WASI SDK directory
function Validate-WasiSdkDirectory {
    param(
        [string]$Path
    )
    
    if (-not (Test-Path -Path $Path -PathType Container)) {
        Write-Host "❌ Error: Directory '$Path' does not exist or is not a directory" -ForegroundColor Red
        return $false
    }
    
    # Detect system architecture
    $systemArch = Get-SystemArchitecture
    
    # Check if the directory contains expected WASI SDK files
    # Adjust expected files based on architecture if needed
    $expectedFiles = @(
        "bin/clang.exe",
        "share/wasi-sysroot/include"
    )
    
    # For non-Windows systems, adjust the expected files
    if (-not $IsWindows) {
        $expectedFiles = @(
            "bin/clang",
            "share/wasi-sysroot/include"
        )
    }
    
    foreach ($file in $expectedFiles) {
        $fullPath = Join-Path -Path $Path -ChildPath $file
        if (-not (Test-Path -Path $fullPath)) {
            Write-Host "❌ Error: Expected file '$file' not found in '$Path'" -ForegroundColor Red
            return $false
        }
    }
    
    return $true
}

# Function to set WASI_SDK_PATH environment variable
function Set-WasiSdkPath {
    param(
        [string]$Path,
        [string]$Scope = "User"
    )
    
    Write-Host "📦 Setting WASI_SDK_PATH environment variable..."
    
    # Set environment variable for current session
    $env:WASI_SDK_PATH = $Path
    Write-Host "✅ Set WASI_SDK_PATH for current session: $Path" -ForegroundColor Green
    
    # Set environment variable permanently with the specified scope
    [Environment]::SetEnvironmentVariable("WASI_SDK_PATH", $Path, $Scope)
    Write-Host "✅ Set WASI_SDK_PATH permanently for ${Scope}: $Path" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "📋 Verification:"
    Write-Host "To verify the environment variable is set correctly, run:"
    Write-Host "  echo $env:WASI_SDK_PATH  # In PowerShell"
    Write-Host "  echo %WASI_SDK_PATH%   # In Command Prompt"
    Write-Host ""
    Write-Host "🎯 Now you can build the project with WASM support!"
    Write-Host "   Run: npm run build-grammar"
}

# Main script execution
if ($Help) {
    Show-Help
    exit 0
}

Write-Host "🚀 Setting up WASI SDK for Cangjie Extension"
Write-Host ""

# Check if WASI SDK is already configured
if (Test-WasiSdkConfigured -Path $WasiSdkPath -Scope $Scope) {
    Write-Host ""
    Write-Host "🎉 WASI SDK is already configured correctly!" -ForegroundColor Green
    Write-Host "📝 Tip: Use this script with -WasiSdkPath parameter to reconfigure with a different directory." -ForegroundColor Yellow
    exit 0
}

# If no path provided, prompt user
if ([string]::IsNullOrEmpty($WasiSdkPath)) {
    $WasiSdkPath = Read-Host -Prompt "Enter the path to your extracted WASI SDK directory (e.g., C:\Users\username\Downloads\wasi-sdk-29.0)"
}

# Validate the path
if (-not (Validate-WasiSdkDirectory -Path $WasiSdkPath)) {
    Write-Host ""
    Write-Host "❌ Invalid WASI SDK directory. Please check the path and try again." -ForegroundColor Red
    exit 1
}

# Set the environment variable
Set-WasiSdkPath -Path $WasiSdkPath -Scope $Scope

Write-Host "🎉 WASI SDK setup completed successfully!" -ForegroundColor Green
Write-Host ""


