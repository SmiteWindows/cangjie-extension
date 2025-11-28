# Setup Cangjie SDK Script for Windows
# This script downloads, installs, and configures the Cangjie SDK

#Requires -Version 7.0

param(
    [string]$SdkVersion = "1.0.4",
    [string]$InstallPath = "C:\Program Files\Cangjie",
    [switch]$Force = $false,
    [switch]$Help = $false,
    [switch]$NoAdminCheck = $false
)

# Function to show help information
function Show-Help {
    Write-Host "Setup Cangjie SDK Script for Windows"
    Write-Host ""
    Write-Host "Usage: .\setup-cangjie-sdk.ps1 [-SdkVersion <version>] [-InstallPath <path>] [-Force] [-Help] [-NoAdminCheck]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -SdkVersion <version>  - Cangjie SDK version to install (default: 1.0.4)"
    Write-Host "  -InstallPath <path>    - Installation directory (default: C:\Program Files\Cangjie)"
    Write-Host "  -Force                 - Force installation even if directory exists"
    Write-Host "  -Help                  - Show this help information"
    Write-Host "  -NoAdminCheck          - Skip administrator privilege check (not recommended)"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\setup-cangjie-sdk.ps1"
    Write-Host "  .\setup-cangjie-sdk.ps1 -SdkVersion 1.0.4 -InstallPath D:\Cangjie"
    Write-Host "  .\setup-cangjie-sdk.ps1 -Help"
}

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Function to download Cangjie SDK
function Download-CangjieSdk {
    param(
        [string]$Version,
        [string]$OutputPath
    )
    
    Write-Host "📥 Downloading Cangjie SDK $Version..."
    
    $downloadUrl = "https://cangjie-lang.cn/download/$Version"
    
    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $OutputPath -UseBasicParsing -ErrorAction Stop
        Write-Host "✅ Download completed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ Download failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📝 Tip: Check your internet connection and try again." -ForegroundColor Yellow
        return $false
    }
}

# Function to install Cangjie SDK
function Install-CangjieSdk {
    param(
        [string]$ZipPath,
        [string]$InstallPath,
        [bool]$Force
    )
    
    Write-Host "📦 Installing Cangjie SDK to $InstallPath..."
    
    # Check if directory exists
    if (Test-Path -Path $InstallPath -PathType Container) {
        if (-not $Force) {
            Write-Host "❌ Error: Directory '$InstallPath' already exists. Use -Force to overwrite." -ForegroundColor Red
            return $false
        } else {
            Write-Host "⚠️  Directory '$InstallPath' already exists. Overwriting..." -ForegroundColor Yellow
            Remove-Item -Path $InstallPath -Recurse -Force -ErrorAction Stop
        }
    }
    
    # Create installation directory
    New-Item -Path $InstallPath -ItemType Directory -Force | Out-Null
    
    # Extract the ZIP file
    try {
        Expand-Archive -Path $ZipPath -DestinationPath $InstallPath -Force -ErrorAction Stop
        Write-Host "✅ Installation completed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📝 Tip: Check if you have permission to write to '$InstallPath'." -ForegroundColor Yellow
        return $false
    }
}

# Function to configure environment variables
function Configure-EnvironmentVariables {
    param(
        [string]$InstallPath
    )
    
    Write-Host "🔧 Configuring environment variables..."
    
    # Set CANGJIE_HOME environment variable
    try {
        [Environment]::SetEnvironmentVariable("CANGJIE_HOME", $InstallPath, "User")
        $env:CANGJIE_HOME = $InstallPath
        Write-Host "✅ Set CANGJIE_HOME to $InstallPath" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to set CANGJIE_HOME: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    
    # Add bin directory to PATH
    $binPath = Join-Path -Path $InstallPath -ChildPath "bin"
    $currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    
    if ($currentPath -notlike "*$binPath*") {
        try {
            $newPath = "$currentPath;$binPath"
            [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
            $env:PATH += ";$binPath"
            Write-Host "✅ Added $binPath to PATH" -ForegroundColor Green
        } catch {
            Write-Host "❌ Failed to update PATH: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    } else {
        Write-Host "✅ $binPath is already in PATH" -ForegroundColor Green
    }
    
    return $true
}

# Function to check if Cangjie SDK is already installed
function Test-CangjieSdkInstalled {
    param(
        [string]$InstallPath
    )
    
    Write-Host "🔍 Checking if Cangjie SDK is already installed at $InstallPath..."
    
    # Check if bin directory exists
    $binPath = Join-Path -Path $InstallPath -ChildPath "bin"
    if (-not (Test-Path -Path $binPath -PathType Container)) {
        Write-Host "ℹ️  Cangjie SDK not found at $InstallPath" -ForegroundColor Cyan
        return $false
    }
    
    # Check if cjc compiler exists
    $cjcPath = Join-Path -Path $binPath -ChildPath "cjc.exe"
    if (-not (Test-Path -Path $cjcPath -PathType Leaf)) {
        Write-Host "ℹ️  Cangjie SDK not found at $InstallPath (missing cjc.exe)" -ForegroundColor Cyan
        return $false
    }
    
    # Check if cjpm package manager exists
    $cjpmPath = Join-Path -Path $binPath -ChildPath "cjpm.exe"
    if (-not (Test-Path -Path $cjpmPath -PathType Leaf)) {
        Write-Host "ℹ️  Cangjie SDK not found at $InstallPath (missing cjpm.exe)" -ForegroundColor Cyan
        return $false
    }
    
    # Test running cjc --version
    try {
        $cjcVersion = & $cjcPath --version 2>&1
        Write-Host "✅ Cangjie SDK is already installed at $InstallPath" -ForegroundColor Green
        Write-Host "   cjc version: $cjcVersion" -ForegroundColor Green
    } catch {
        Write-Host "ℹ️  Cangjie SDK files found but not functional: $($_.Exception.Message)" -ForegroundColor Cyan
        return $false
    }
    
    return $true
}

# Function to verify installation
function Verify-Installation {
    param(
        [string]$InstallPath
    )
    
    Write-Host "🧪 Verifying installation..."
    
    # Check if bin directory exists
    $binPath = Join-Path -Path $InstallPath -ChildPath "bin"
    if (-not (Test-Path -Path $binPath -PathType Container)) {
        Write-Host "❌ Error: Bin directory not found at $binPath" -ForegroundColor Red
        return $false
    }
    
    # Check if cjc compiler exists
    $cjcPath = Join-Path -Path $binPath -ChildPath "cjc.exe"
    if (-not (Test-Path -Path $cjcPath -PathType Leaf)) {
        Write-Host "❌ Error: cjc.exe not found at $cjcPath" -ForegroundColor Red
        return $false
    }
    
    # Check if cjpm package manager exists
    $cjpmPath = Join-Path -Path $binPath -ChildPath "cjpm.exe"
    if (-not (Test-Path -Path $cjpmPath -PathType Leaf)) {
        Write-Host "❌ Error: cjpm.exe not found at $cjpmPath" -ForegroundColor Red
        return $false
    }
    
    # Test running cjc --version
    try {
        $cjcVersion = & $cjcPath --version 2>&1
        Write-Host "✅ cjc version: $cjcVersion" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  Warning: Failed to run cjc --version: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    # Test running cjpm --version
    try {
        $cjpmVersion = & $cjpmPath --version 2>&1
        Write-Host "✅ cjpm version: $cjpmVersion" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  Warning: Failed to run cjpm --version: $($_.Exception.Message)" -ForegroundColor Yellow
    }
    
    return $true
}

# Main script execution
if ($Help) {
    Show-Help
    exit 0
}

Write-Host "🚀 Starting Cangjie SDK setup..." -ForegroundColor Green
Write-Host ""

# Check if running as administrator
if (-not $NoAdminCheck -and -not (Test-Administrator)) {
    Write-Host "❌ Error: This script requires administrator privileges to install to '$InstallPath'." -ForegroundColor Red
    Write-Host "📝 Tip: Right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Write-Host "📝 Tip: Use -NoAdminCheck to skip this check (not recommended)." -ForegroundColor Yellow
    exit 1
}

# Check if Cangjie SDK is already installed
if (Test-CangjieSdkInstalled -InstallPath $InstallPath) {
    if (-not $Force) {
        Write-Host ""
        Write-Host "📝 Tip: Use -Force to reinstall or upgrade the SDK." -ForegroundColor Yellow
        exit 0
    } else {
        Write-Host "⚠️  Reinstalling Cangjie SDK with -Force option..." -ForegroundColor Yellow
        Write-Host ""
    }
} else {
    Write-Host ""
}

# Create a temporary directory for the download
$tempDir = Join-Path -Path $env:TEMP -ChildPath "cangjie-sdk-$((Get-Date).ToString('yyyyMMdd-HHmmss'))"
New-Item -Path $tempDir -ItemType Directory -Force | Out-Null

# Set the output path for the ZIP file
$zipPath = Join-Path -Path $tempDir -ChildPath "cangjie-sdk.zip"

# Download the SDK
if (-not (Download-CangjieSdk -Version $SdkVersion -OutputPath $zipPath)) {
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# Install the SDK
if (-not (Install-CangjieSdk -ZipPath $zipPath -InstallPath $InstallPath -Force $Force)) {
    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# Configure environment variables
if (-not (Configure-EnvironmentVariables -InstallPath $InstallPath)) {
    Write-Host ""
    Write-Host "⚠️  Warning: Environment variables configuration failed. You may need to configure them manually." -ForegroundColor Yellow
}

# Verify installation
if (-not (Verify-Installation -InstallPath $InstallPath)) {
    Write-Host ""
    Write-Host "⚠️  Warning: Installation verification failed. Some components may not be working correctly." -ForegroundColor Yellow
}

# Clean up temporary files
Write-Host ""
Write-Host "🧹 Cleaning up temporary files..."
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "✅ Cleanup completed!" -ForegroundColor Green

# Show completion message
Write-Host ""
Write-Host "🎉 Cangjie SDK setup completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Installation Summary:"
Write-Host "   Version: $SdkVersion"
Write-Host "   Install Path: $InstallPath"
Write-Host "   CANGJIE_HOME: $env:CANGJIE_HOME"
Write-Host "   Bin Directory: $($InstallPath)\bin"
Write-Host ""
Write-Host "📝 Next Steps:"
Write-Host "1. Open a new PowerShell window to use the updated environment variables"
Write-Host "2. Run 'cjc --version' to verify the compiler is working"
Write-Host "3. Run 'cjpm --version' to verify the package manager is working"
Write-Host "4. Start developing with Cangjie!"
Write-Host ""
