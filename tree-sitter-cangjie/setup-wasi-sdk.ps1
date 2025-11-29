# Setup WASI SDK Script for Cangjie Extension
# This script helps configure the WASI_SDK_PATH environment variable

#Requires -Version 7.0

param(
    [string]$WasiSdkPath,
    [string]$Scope = "User",
    [switch]$Help = $false
)

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
    Write-Host "   Run: tree-sitter generate"
    Write-Host "   Then build for WASM target: cargo build --target wasm32-unknown-unknown --release"
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
