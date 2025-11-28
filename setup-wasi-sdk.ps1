# Setup WASI SDK Script for Cangjie Extension
# This script helps configure the WASI_SDK_PATH environment variable

#Requires -Version 7.0

param(
    [string]$WasiSdkPath,
    [switch]$Help = $false
)

# Function to show help information
function Show-Help {
    Write-Host "Setup WASI SDK Script for Cangjie Extension"
    Write-Host ""
    Write-Host "Usage: .\setup-wasi-sdk.ps1 [-WasiSdkPath <path>] [-Help]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -WasiSdkPath <path>  - Path to the extracted WASI SDK directory (e.g., C:\Users\username\Downloads\wasi-sdk-29.0)"
    Write-Host "  -Help               - Show this help information"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\setup-wasi-sdk.ps1 -WasiSdkPath "C:\Users\username\Downloads\wasi-sdk-29.0""
    Write-Host "  .\setup-wasi-sdk.ps1 -Help"
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
    
    # Check if the directory contains expected WASI SDK files
    $expectedFiles = @(
        "bin/clang.exe",
        "share/wasi-sysroot/include"
    )
    
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
        [string]$Path
    )
    
    Write-Host "📦 Setting WASI_SDK_PATH environment variable..."
    
    # Set environment variable for current session
    $env:WASI_SDK_PATH = $Path
    Write-Host "✅ Set WASI_SDK_PATH for current session: $Path" -ForegroundColor Green
    
    # Set environment variable permanently for the user
    [Environment]::SetEnvironmentVariable("WASI_SDK_PATH", $Path, "User")
    Write-Host "✅ Set WASI_SDK_PATH permanently for user: $Path" -ForegroundColor Green
    
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
Set-WasiSdkPath -Path $WasiSdkPath

Write-Host "🎉 WASI SDK setup completed successfully!" -ForegroundColor Green
Write-Host ""
