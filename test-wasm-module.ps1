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

<#
.SYNOPSIS
    Tests, validates, and optionally runs WASM modules built from the project.
.DESCRIPTION
    This script provides comprehensive WASM module validation, including:
    - Checking and automatic installation of wasmtime
    - Verification of WASM file existence and details
    - Validation of WASM module structure
    - Optional WASM module execution
    - Support for multiple WASM targets
    - Cross-platform support (Windows, Linux, macOS)
.EXAMPLE
    .\test-wasm-module.ps1
    Runs the full validation suite on the WASM module.
.EXAMPLE
    .\test-wasm-module.ps1 -InstallWasmtime
    Installs wasmtime automatically and runs validation.
.EXAMPLE
    .\test-wasm-module.ps1 -WasmTarget wasm32-unknown-unknown
    Validates the WASM module for web target.
.EXAMPLE
    .\test-wasm-module.ps1 -RunModule
    Validates and runs the WASM module.
.EXAMPLE
    .\test-wasm-module.ps1 -WasmFilePath "path/to/custom.wasm"
    Validates a custom WASM file.
#>

param(
    [switch]$InstallWasmtime = $false,
    [switch]$RunModule = $false,
    [string]$WasmTarget = "wasm32-wasip2",
    [string]$WasmFilePath = "",
    [string]$WasmtimeVersion = "latest",
    [switch]$Help = $false
)

# Set strict mode for better error handling
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Show help if requested
if ($Help) {
    Get-Help -Name $PSCommandPath -Full
    exit 0
}

# Constants
$WASMTIME_RELEASES_URL = "https://github.com/bytecodealliance/wasmtime/releases"

# 从toolchain.json读取Wasmtime版本
$toolchainPath = Join-Path -Path $PSScriptRoot -ChildPath "toolchain.json"
$toolchainContent = Get-Content -Path $toolchainPath -Raw -Encoding utf8
$toolchain = ConvertFrom-Json -InputObject $toolchainContent
$WASMTIME_LATEST_VERSION = "v$($toolchain.versions.wasmtime)"


# Function to check if wasmtime is installed
function Test-WasmtimeInstalled {
    <#
    .SYNOPSIS
        Checks if wasmtime is installed and available in PATH.
    .OUTPUTS
        [bool] $true if wasmtime is installed, $false otherwise.
    #>
    try {
        $null = wasmtime --version 2>&1
        return $true
    } catch [System.Management.Automation.CommandNotFoundException] {
        return $false
    } catch {
        return $false
    }
}

# Function to get wasmtime version
function Get-WasmtimeVersion {
    <#
    .SYNOPSIS
        Gets the installed wasmtime version.
    .OUTPUTS
        [string] The wasmtime version string, or $null if not installed.
    #>
    try {
        $versionOutput = wasmtime --version 2>&1
        if ($versionOutput -match 'wasmtime\s+([vV]?\d+\.\d+\.\d+)') {
            return $matches[1]
        }
        return $versionOutput
    } catch {
        return $null
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
        default {
            # Try using uname for non-Windows systems
            if ($IsLinux -or $IsMacOS) {
                return (uname -m)
            }
            return $arch
        }
    }
}

# Function to get operating system
function Get-OperatingSystem {
    <#
    .SYNOPSIS
        Gets the operating system in a standardized format.
    .OUTPUTS
        [string] Operating system (windows, linux, macos).
    #>
    if ($IsWindows) {
        return "windows"
    } elseif ($IsLinux) {
        return "linux"
    } elseif ($IsMacOS) {
        return "macos"
    } else {
        # Fallback to environment variable
        $os = $env:OS
        if ($os -like "*Windows*" -or $os -like "*windows*") {
            return "windows"
        }
        return "unknown"
    }
}

# Function to check if WASM file exists
function Test-WasmFileExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WasmFilePath
    )
    
    <#
    .SYNOPSIS
        Checks if a WASM file exists.
    .PARAMETER WasmFilePath
        Path to the WASM file.
    .OUTPUTS
        [bool] $true if the file exists, $false otherwise.
    #>
    
    return Test-Path -Path $WasmFilePath -PathType Leaf
}

# Function to validate WASM module
function Validate-WasmModule {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WasmFilePath
    )
    
    <#
    .SYNOPSIS
        Validates a WASM module using wasmtime.
    .PARAMETER WasmFilePath
        Path to the WASM file to validate.
    .OUTPUTS
        [bool] $true if the module is valid, $false otherwise.
    .OUTPUTS
        [string] Validation output messages.
    #>
    
    try {
        $validationOutput = wasmtime validate $WasmFilePath 2>&1
        return $true, $validationOutput
    } catch {
        return $false, $_.Exception.Message
    }
}

# Function to run WASM module
function Run-WasmModule {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WasmFilePath,
        
        [string[]]$Args = @()
    )
    
    <#
    .SYNOPSIS
        Runs a WASM module using wasmtime.
    .PARAMETER WasmFilePath
        Path to the WASM file to run.
    .PARAMETER Args
        Arguments to pass to the WASM module.
    .OUTPUTS
        [bool] $true if the module ran successfully, $false otherwise.
    .OUTPUTS
        [string] Module output.
    #>
    
    try {
        $runOutput = wasmtime run $WasmFilePath $Args 2>&1
        return $true, $runOutput
    } catch {
        return $false, $_.Exception.Message
    }
}

# Function to get WASM file details
function Get-WasmFileDetails {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WasmFilePath
    )
    
    <#
    .SYNOPSIS
        Gets detailed information about a WASM file.
    .PARAMETER WasmFilePath
        Path to the WASM file.
    .OUTPUTS
        [PSCustomObject] Object containing file details.
    #>
    
    $fileInfo = Get-ChildItem -Path $WasmFilePath
    
    return [PSCustomObject]@{ 
        Name = $fileInfo.Name
        Path = $fileInfo.FullName
        SizeKB = [math]::Round($fileInfo.Length / 1KB, 2)
        SizeMB = [math]::Round($fileInfo.Length / 1MB, 2)
        LastModified = $fileInfo.LastWriteTime
        CreationTime = $fileInfo.CreationTime
        Attributes = $fileInfo.Attributes
    }
}

# Function to download and install wasmtime
function Install-Wasmtime {
    param(
        [string]$Version = "latest"
    )
    
    <#
    .SYNOPSIS
        Downloads and installs wasmtime on the current system.
    .DESCRIPTION
        This function downloads and installs wasmtime for the current platform
        and architecture, with support for multiple operating systems.
    .PARAMETER Version
        Version of wasmtime to install (default: latest).
    .OUTPUTS
        [bool] $true if installation succeeded, $false otherwise.
    #>
    
    Write-Host "📥 Starting wasmtime installation..." -ForegroundColor Cyan
    
    # Determine system information
    $os = Get-OperatingSystem
    $arch = Get-SystemArchitecture
    
    if ($os -eq "unknown") {
        Write-Host "❌ Error: Unsupported operating system." -ForegroundColor Red
        return $false
    }
    
    # Determine wasmtime version to install
    $wasmtimeVersion = if ($Version -eq "latest") {
        $WASMTIME_LATEST_VERSION
    } else {
        if ($Version -notlike "v*") {
            "v$Version"
        } else {
            $Version
        }
    }
    
    # Determine download URL based on platform
    $fileName = switch ($os) {
        "windows" { "wasmtime-$wasmtimeVersion-$arch-windows.msi" }
        "linux" { "wasmtime-$wasmtimeVersion-$arch-linux.tar.xz" }
        "macos" { "wasmtime-$wasmtimeVersion-$arch-macos.tar.xz" }
        default { "wasmtime-$wasmtimeVersion-$arch-$os.tar.xz" }
    }
    
    $downloadUrl = "$WASMTIME_RELEASES_URL/download/$wasmtimeVersion/$fileName"
    
    # Set installation paths based on platform
    $tempDir = [System.IO.Path]::GetTempPath()
    $installPath = switch ($os) {
        "windows" { "$env:ProgramFiles\wasmtime" }
        "linux" { "/usr/local/bin" }
        "macos" { "/usr/local/bin" }
        default { "$env:ProgramFiles\wasmtime" }
    }
    
    try {
        # Download wasmtime
        Write-Host "   Downloading wasmtime $wasmtimeVersion for $os-$arch..." -ForegroundColor Yellow
        Write-Host "   From: $downloadUrl" -ForegroundColor DarkGray
        
        if ($os -eq "windows") {
            # Windows-specific installation using MSI
            $msiFile = Join-Path -Path $tempDir -ChildPath "wasmtime.msi"
            
            Invoke-WebRequest -Uri $downloadUrl -OutFile $msiFile -UseBasicParsing -ProgressAction SilentlyContinue
            
            # Verify download
            if (-not (Test-Path -Path $msiFile -PathType Leaf)) {
                Write-Host "❌ Error: Download failed. MSI file not found." -ForegroundColor Red
                return $false
            }
            
            # Install using msiexec
            Write-Host "   Installing wasmtime using MSI..." -ForegroundColor Yellow
            $msiArgs = @(
                "/i", "`"$msiFile`"",
                "/quiet",
                "/norestart",
                "/l*v", "`"$tempDir\wasmtime-install.log`""
            )
            
            Start-Process -FilePath "msiexec.exe" -ArgumentList $msiArgs -Wait -NoNewWindow
            
            # Verify installation
            if (-not (Test-WasmtimeInstalled)) {
                Write-Host "❌ Error: MSI installation completed but wasmtime not found." -ForegroundColor Red
                Write-Host "   Check installation log: $tempDir\wasmtime-install.log" -ForegroundColor DarkRed
                return $false
            }
            
            # Clean up
            Remove-Item -Path $msiFile -Force -ErrorAction SilentlyContinue
            Remove-Item -Path "$tempDir\wasmtime-install.log" -Force -ErrorAction SilentlyContinue
        } else {
            # Linux/macOS installation using tar.xz
            $extractPath = Join-Path -Path $tempDir -ChildPath "wasmtime-install"
            $tarFile = Join-Path -Path $tempDir -ChildPath "wasmtime.tar.xz"
            
            # Create temporary directory
            if (Test-Path -Path $extractPath) {
                Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
            }
            New-Item -Path $extractPath -ItemType Directory | Out-Null
            
            # Download using wget or curl
            if ($IsLinux) {
                if (Test-CommandAvailable "wget") {
                    wget -q $downloadUrl -O $tarFile
                } else {
                    curl -s -L $downloadUrl -o $tarFile
                }
            } elseif ($IsMacOS) {
                curl -s -L $downloadUrl -o $tarFile
            }
            
            # Verify download
            if (-not (Test-Path -Path $tarFile -PathType Leaf)) {
                Write-Host "❌ Error: Download failed. File not found." -ForegroundColor Red
                return $false
            }
            
            # Extract the tar.xz file
            Write-Host "   Extracting wasmtime..." -ForegroundColor Yellow
            tar -xf $tarFile -C $extractPath
            
            # Get the extracted directory name
            $extractedDir = Get-ChildItem -Path $extractPath -Directory | Select-Object -First 1
            if (-not $extractedDir) {
                Write-Host "❌ Error: Failed to find extracted directory." -ForegroundColor Red
                return $false
            }
            
            # Install wasmtime binary
            Write-Host "   Installing wasmtime to $installPath..." -ForegroundColor Yellow
            
            $wasmtimeExe = "wasmtime"
            $sourceExe = Join-Path -Path $extractedDir.FullName -ChildPath $wasmtimeExe
            $targetExe = Join-Path -Path $installPath -ChildPath $wasmtimeExe
            
            # Linux/macOS may require sudo
            try {
                Copy-Item -Path $sourceExe -Destination $targetExe -Force
                chmod +x $targetExe
            } catch {
                Write-Host "⚠️  Warning: Could not copy file. Trying with sudo..." -ForegroundColor Yellow
                sudo cp $sourceExe $targetExe 2>&1 | Out-Null
                sudo chmod +x $targetExe 2>&1 | Out-Null
            }
            
            # Clean up
            Remove-Item -Path $tarFile -Force -ErrorAction SilentlyContinue
            Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        Write-Host "✅ wasmtime $wasmtimeVersion installed successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ Error during wasmtime installation: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "📝 Tip: Try installing wasmtime manually from $WASMTIME_RELEASES_URL" -ForegroundColor Yellow
        
        # Clean up partial installation
        try {
            if ($os -eq "windows") {
                $msiFile = Join-Path -Path $tempDir -ChildPath "wasmtime.msi"
                Remove-Item -Path $msiFile -Force -ErrorAction SilentlyContinue
                Remove-Item -Path "$tempDir\wasmtime-install.log" -Force -ErrorAction SilentlyContinue
            } else {
                $extractPath = Join-Path -Path $tempDir -ChildPath "wasmtime-install"
                $tarFile = Join-Path -Path $tempDir -ChildPath "wasmtime.tar.xz"
                Remove-Item -Path $tarFile -Force -ErrorAction SilentlyContinue
                Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
            }
        } catch {}
        
        return $false
    }
}

# Helper function to check if a command is available
function Test-CommandAvailable {
    param(
        [string]$Command
    )
    
    <#
    .SYNOPSIS
        Checks if a command is available in the current environment.
    .PARAMETER Command
        Command to check for.
    .OUTPUTS
        [bool] $true if command is available, $false otherwise.
    #>
    
    try {
        $null = Get-Command $Command -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Function to prompt user for wasmtime installation
function Prompt-WasmtimeInstallation {
    <#
    .SYNOPSIS
        Prompts the user to install wasmtime if it's not installed.
    .DESCRIPTION
        This function asks the user if they want to install wasmtime automatically.
    .OUTPUTS
        [bool] $true if installation was successful or skipped, $false otherwise.
    #>
    
    Write-Host "" -ForegroundColor White
    
    do {
        $response = Read-Host "Would you like to automatically install wasmtime? (Y/N)"
        $response = $response.Trim().ToUpper()
        
        if ($response -eq "Y" -or $response -eq "YES") {
            return Install-Wasmtime
        } elseif ($response -eq "N" -or $response -eq "NO") {
            Write-Host "⚠️  wasmtime installation skipped." -ForegroundColor Yellow
            Write-Host "📝 Please install wasmtime manually from $WASMTIME_RELEASES_URL" -ForegroundColor Cyan
            return $false
        } else {
            Write-Host "❌ Invalid input. Please enter Y or N." -ForegroundColor Red
        }
    } while ($true)
}

# Main script execution
Write-Host "🚀 Starting WASM module validation..." -ForegroundColor Green
Write-Host "=" * 80
Write-Host ""

# Show script parameters
Write-Host "📋 Script Parameters:" -ForegroundColor Magenta
Write-Host "   - InstallWasmtime: $InstallWasmtime" -ForegroundColor Magenta
Write-Host "   - RunModule: $RunModule" -ForegroundColor Magenta
Write-Host "   - WasmTarget: $WasmTarget" -ForegroundColor Magenta
Write-Host "   - WasmFilePath: $($WasmFilePath -eq '' ? 'Default' : $WasmFilePath)" -ForegroundColor Magenta
Write-Host "   - WasmtimeVersion: $WasmtimeVersion" -ForegroundColor Magenta
Write-Host ""

# Step 1: Check wasmtime installation and version
Write-Host "1. Checking wasmtime installation..." -ForegroundColor Cyan

if (-not (Test-WasmtimeInstalled)) {
    Write-Host "⚠️  wasmtime is not installed." -ForegroundColor Yellow
    
    if ($InstallWasmtime) {
        # Install wasmtime automatically if -InstallWasmtime switch is provided
        if (-not (Install-Wasmtime -Version $WasmtimeVersion)) {
            exit 1
        }
    } else {
        # Prompt user for installation
        if (-not (Prompt-WasmtimeInstallation)) {
            exit 1
        }
    }
}

$wasmtimeVersion = Get-WasmtimeVersion
Write-Host "✅ wasmtime is installed: $wasmtimeVersion" -ForegroundColor Green
Write-Host ""

# Step 2: Determine WASM file path
Write-Host "2. Determining WASM file path..." -ForegroundColor Cyan

$projectRoot = $PSScriptRoot

# Use custom WASM file path if provided, otherwise use default path
if (-not [string]::IsNullOrEmpty($WasmFilePath)) {
    if (-not (Test-Path -Path $WasmFilePath -IsValid)) {
        Write-Host "❌ Error: Invalid WASM file path: $WasmFilePath" -ForegroundColor Red
        exit 1
    }
    $resolvedWasmFilePath = Resolve-Path -Path $WasmFilePath -ErrorAction Stop
} else {
    # Default WASM file path based on target
    $wasmDirectory = Join-Path -Path $projectRoot -ChildPath "tree-sitter-cangjie\target\$WasmTarget\release"
    $resolvedWasmFilePath = Join-Path -Path $wasmDirectory -ChildPath "tree_sitter_cangjie.wasm"
    
    # List directory contents for debugging
    Write-Host "   Checking default directory: $wasmDirectory" -ForegroundColor Yellow
    if (Test-Path -Path $wasmDirectory -PathType Container) {
        Write-Host "   Directory contents:" -ForegroundColor DarkYellow
        Get-ChildItem -Path $wasmDirectory | Format-Table -AutoSize
    } else {
        Write-Host "   ⚠️  Directory not found: $wasmDirectory" -ForegroundColor Yellow
        Write-Host "   📝 Tip: Build the project first for target $WasmTarget" -ForegroundColor DarkYellow
    }
}

Write-Host ""

# Step 3: Check WASM file existence
Write-Host "3. Checking WASM file existence..." -ForegroundColor Cyan

if (-not (Test-WasmFileExists -WasmFilePath $resolvedWasmFilePath)) {
    Write-Host "❌ Error: WASM file not found at: $resolvedWasmFilePath" -ForegroundColor Red
    if ([string]::IsNullOrEmpty($WasmFilePath)) {
        Write-Host "📝 Tip: Build the project first using 'npm run build-wasm-rust' for wasm32-wasip2 target" -ForegroundColor Yellow
        Write-Host "   or 'npm run build-wasm-web' for wasm32-unknown-unknown target" -ForegroundColor Yellow
    }
    exit 1
}

Write-Host "✅ WASM file found: $resolvedWasmFilePath" -ForegroundColor Green

# Show WASM file details
Write-Host "   File details:" -ForegroundColor Yellow
$wasmDetails = Get-WasmFileDetails -WasmFilePath $resolvedWasmFilePath
Write-Host "   - Name: $($wasmDetails.Name)" -ForegroundColor Yellow
Write-Host "   - Path: $($wasmDetails.Path)" -ForegroundColor Yellow
Write-Host "   - Size: $($wasmDetails.SizeKB) KB ($($wasmDetails.SizeMB) MB)" -ForegroundColor Yellow
Write-Host "   - Last modified: $($wasmDetails.LastModified)" -ForegroundColor Yellow
Write-Host "   - Created: $($wasmDetails.CreationTime)" -ForegroundColor Yellow
Write-Host ""

# Step 4: Validate WASM module
Write-Host "4. Validating WASM module..." -ForegroundColor Cyan

$isValid, $validationOutput = Validate-WasmModule -WasmFilePath $resolvedWasmFilePath
if ($isValid) {
    Write-Host "✅ WASM module is valid!" -ForegroundColor Green
    if ($validationOutput) {
        Write-Host "   Validation output: $validationOutput" -ForegroundColor DarkGreen
    }
} else {
    Write-Host "❌ Error: WASM module validation failed!" -ForegroundColor Red
    Write-Host "   Validation error: $validationOutput" -ForegroundColor DarkRed
    exit 1
}

Write-Host ""

# Step 5: Run WASM module if requested
if ($RunModule) {
    Write-Host "5. Running WASM module..." -ForegroundColor Cyan
    
    $runSuccess, $runOutput = Run-WasmModule -WasmFilePath $resolvedWasmFilePath
    if ($runSuccess) {
        Write-Host "✅ WASM module executed successfully!" -ForegroundColor Green
        if ($runOutput) {
            Write-Host "   Module output:" -ForegroundColor DarkGreen
            Write-Host "   ------------------------------" -ForegroundColor DarkGreen
            Write-Host $runOutput -ForegroundColor DarkGreen
            Write-Host "   ------------------------------" -ForegroundColor DarkGreen
        }
    } else {
        Write-Host "⚠️  WASM module execution failed!" -ForegroundColor Yellow
        Write-Host "   Execution error: $runOutput" -ForegroundColor DarkYellow
        # Don't exit on execution failure, as validation passed
    }
    
    Write-Host ""
}

# Step 6: Show summary
Write-Host "=" * 80
Write-Host "🎉 WASM module validation completed successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "📋 Validation Summary:" -ForegroundColor Cyan
Write-Host "   - wasmtime: Installed and working ($wasmtimeVersion)" -ForegroundColor Cyan
Write-Host "   - WASM target: $WasmTarget" -ForegroundColor Cyan
Write-Host "   - WASM file: $($wasmDetails.Name)" -ForegroundColor Cyan
Write-Host "   - File size: $($wasmDetails.SizeKB) KB" -ForegroundColor Cyan
Write-Host "   - Validation: Passed" -ForegroundColor Cyan
if ($RunModule) {
    $executionStatus = if ($runSuccess) { "Passed" } else { "Failed" }
    Write-Host "   - Execution: $executionStatus" -ForegroundColor Cyan
}
Write-Host ""

Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "   - Run the module manually: wasmtime run $resolvedWasmFilePath" -ForegroundColor Cyan
if ([string]::IsNullOrEmpty($WasmFilePath)) {
    Write-Host "   - Build for wasm32-wasip2: npm run build-wasm-rust" -ForegroundColor Cyan
    Write-Host "   - Build for wasm32-unknown-unknown: npm run build-wasm-web" -ForegroundColor Cyan
    Write-Host "   - Build all: npm run build-grammar" -ForegroundColor Cyan
}
Write-Host "   - Clean and rebuild: npm run clean && npm run build-grammar" -ForegroundColor Cyan
Write-Host "   - Test with different target: .\test-wasm-module.ps1 -WasmTarget wasm32-unknown-unknown" -ForegroundColor Cyan
if (-not $RunModule) {
    Write-Host "   - Validate and run: .\test-wasm-module.ps1 -RunModule" -ForegroundColor Cyan
}
Write-Host ""

Write-Host "💡 Tips:" -ForegroundColor Magenta
Write-Host "   - Use -WasmFilePath to validate custom WASM files" -ForegroundColor Magenta
Write-Host "   - Use -WasmTarget to specify different WASM targets" -ForegroundColor Magenta
Write-Host "   - Use -InstallWasmtime for automatic wasmtime installation" -ForegroundColor Magenta
Write-Host "   - Use -RunModule to execute the WASM module after validation" -ForegroundColor Magenta
Write-Host ""


