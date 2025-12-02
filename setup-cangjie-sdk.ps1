<#
.SYNOPSIS
    Downloads, installs, and configures the Cangjie SDK on Windows.

.DESCRIPTION
    This script automates the process of downloading the specified version of the Cangjie SDK,
    installing it to the specified directory, and configuring the necessary environment variables.
    It supports both x86_64 and aarch64 architectures.

.PARAMETER SdkVersion
    The version of the Cangjie SDK to install. Defaults to "1.0.4".

.PARAMETER InstallPath
    The directory where the Cangjie SDK will be installed. Defaults to "C:\Program Files\Cangjie".

.PARAMETER Force
    If specified, forces installation even if the directory already exists, overwriting any existing files.

.PARAMETER Help
    If specified, displays this help information and exits.

.PARAMETER NoAdminCheck
    If specified, skips the administrator privilege check. Not recommended for system-wide installations.

.EXAMPLE
    .\setup-cangjie-sdk.ps1
    Installs the default version of the Cangjie SDK to the default directory.

.EXAMPLE
    .\setup-cangjie-sdk.ps1 -SdkVersion 1.0.4 -InstallPath D:\Cangjie
    Installs version 1.0.4 of the Cangjie SDK to the D:\Cangjie directory.

.EXAMPLE
    .\setup-cangjie-sdk.ps1 -Force
    Forces reinstallation of the SDK, overwriting any existing files.

.EXAMPLE
    .\setup-cangjie-sdk.ps1 -Help
    Displays help information.

.NOTES
    This script requires PowerShell 7 or later.
    Administrator privileges are recommended for system-wide installations.
    The script automatically handles architecture detection (x86_64, aarch64).
    It sets the CANGJIE_HOME environment variable and adds the bin directory to the PATH.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [string]$SdkVersion = "1.0.4",
    [string]$InstallPath,
    [switch]$Force = $false,
    [switch]$Help = $false,
    [switch]$NoAdminCheck = $false
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

# Detect system architecture
$systemArch = Get-SystemArchitecture

# Set default install path based on architecture
if (-not $InstallPath) {
    if ($systemArch -eq "aarch64") {
        $InstallPath = "C:\Program Files\Cangjie"
    } else {
        $InstallPath = "C:\Program Files\Cangjie"
    }
}

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
        [string]$OutputPath,
        [string]$Architecture
    )
    
    Write-Host "📥 Downloading Cangjie SDK $Version for $Architecture..."
    
    # Use architecture-specific download URL if available
    # If architecture-specific URL fails, fall back to generic URL
    $downloadUrl = "https://cangjie-lang.cn/download/$Version?arch=$Architecture"
    $fallbackUrl = "https://cangjie-lang.cn/download/$Version"
    
    try {
        # Try architecture-specific URL first
        Write-Host "   Trying architecture-specific URL: $downloadUrl" -ForegroundColor DarkGray
        Invoke-WebRequest -Uri $downloadUrl -OutFile $OutputPath -UseBasicParsing -ErrorAction Stop
        Write-Host "✅ Download completed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "⚠️  Architecture-specific download failed: $($_.Exception.Message)" -ForegroundColor Yellow
        Write-Host "   Falling back to generic URL: $fallbackUrl" -ForegroundColor DarkGray
        
        # Try fallback URL
        try {
            Invoke-WebRequest -Uri $fallbackUrl -OutFile $OutputPath -UseBasicParsing -ErrorAction Stop
            Write-Host "✅ Download completed successfully with fallback URL!" -ForegroundColor Green
            return $true
        } catch {
            Write-Host "❌ Download failed: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "📝 Tip: Check your internet connection and try again." -ForegroundColor Yellow
            return $false
        }
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
if (-not (Download-CangjieSdk -Version $SdkVersion -OutputPath $zipPath -Architecture $systemArch)) {
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


