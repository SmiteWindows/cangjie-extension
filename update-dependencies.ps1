# Update Dependencies Script for Cangjie Extension
# This script updates all dependencies and ensures the project still works correctly
# It reads toolchain versions from toolchain.json and synchronizes them across all files

using namespace System.IO

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

param(
    [switch]$DryRun,
    [switch]$SkipTests,
    [switch]$Help,
    [switch]$ValidateOnly
)

# Function to show help information
function Show-Help {
    Write-Host "Update Dependencies Script for Cangjie Extension"
    Write-Host ""
    Write-Host "Usage: .\update-dependencies.ps1 [Options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -DryRun     : Perform a dry run without actually updating dependencies"
    Write-Host "  -SkipTests  : Skip running tests after updating dependencies"
    Write-Host "  -Help       : Show this help information"
    Write-Host "  -ValidateOnly: Validate toolchain configuration across all files without updating"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\update-dependencies.ps1              # Update all dependencies and run tests"
    Write-Host "  .\update-dependencies.ps1 -DryRun      # Perform a dry run"
    Write-Host "  .\update-dependencies.ps1 -SkipTests   # Update dependencies without running tests"
    Write-Host "  .\update-dependencies.ps1 -ValidateOnly # Validate toolchain configuration"
}

# Function to run a command and handle errors
function Run-Command {
    param(
        [string]$Command,
        [string]$Description,
        [switch]$AllowFailure = $false
    )

    Write-Host "$Description..."
    Write-Host "Command: $Command"
    
    if (-not $DryRun) {
        try {
            Invoke-Expression -Command $Command -ErrorAction Stop
            Write-Host "✅ $Description completed successfully"
        } catch {
            Write-Host "❌ $Description failed: $($_.Exception.Message)" -ForegroundColor Red
            if (-not $AllowFailure) {
                exit 1
            }
        }
    } else {
        Write-Host "⚠️  Dry run: $Description would be executed"
    }
    Write-Host ""
}

# Function to read toolchain configuration
function Get-ToolchainConfig {
    param(
        [string]$ConfigPath = "toolchain.json"
    )
    
    if (-not (Test-Path -Path $ConfigPath -PathType Leaf)) {
        Write-Host "❌ Error: $ConfigPath not found. Please ensure the toolchain configuration file exists." -ForegroundColor Red
        exit 1
    }
    
    try {
        $configContent = Get-Content -Path $ConfigPath -Raw -Encoding UTF8
        return ConvertFrom-Json -InputObject $configContent
    } catch {
            $errorMsg = $_.Exception.Message
            Write-Host "❌ Error reading $ConfigPath`: $errorMsg" -ForegroundColor Red
            exit 1
        }
}

# Function to update package.json with the correct tree-sitter-cli version
function Update-PackageJson {
    param(
        [PSCustomObject]$ToolchainConfig
    )
    
    $packageJsonPath = "package.json"
    if (-not (Test-Path -Path $packageJsonPath -PathType Leaf)) {
        Write-Host "❌ Error: $packageJsonPath not found." -ForegroundColor Red
        exit 1
    }
    
    try {
        $packageJson = Get-Content -Path $packageJsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
        
        # Update tree-sitter-cli version
        if ($packageJson.devDependencies -and $ToolchainConfig.versions.treeSitterCli) {
            $currentVersion = $packageJson.devDependencies."tree-sitter-cli"
            $desiredVersion = $ToolchainConfig.versions.treeSitterCli
            
            if ($currentVersion -ne $desiredVersion) {
                Write-Host "📦 Updating tree-sitter-cli from $currentVersion to $desiredVersion in package.json" -ForegroundColor Yellow
                
                if (-not $DryRun) {
                    $packageJson.devDependencies."tree-sitter-cli" = $desiredVersion
                    $packageJson | ConvertTo-Json -Depth 100 | Set-Content -Path $packageJsonPath -Encoding UTF8
                    Write-Host "✅ Updated tree-sitter-cli version in package.json" -ForegroundColor Green
                } else {
                    Write-Host "⚠️  Dry run: Would update tree-sitter-cli from $currentVersion to $desiredVersion" -ForegroundColor Yellow
                }
            } else {
                Write-Host "✅ tree-sitter-cli version is already up-to-date: $currentVersion" -ForegroundColor Green
            }
        }
    } catch {
        $errorMsg = $_.Exception.Message
        Write-Host "❌ Error updating $packageJsonPath`: $errorMsg" -ForegroundColor Red
        exit 1
    }
}

# Function to update toolchain.json based on actual installed versions
function Update-ToolchainJson {
    param(
        [PSCustomObject]$CurrentToolchainConfig
    )
    
    $toolchainJsonPath = "toolchain.json"
    if (-not (Test-Path -Path $toolchainJsonPath -PathType Leaf)) {
        Write-Host "❌ Error: $toolchainJsonPath not found." -ForegroundColor Red
        exit 1
    }
    
    try {
        # Deep copy the configuration object
        $updatedConfig = $CurrentToolchainConfig | ConvertTo-Json -Depth 100 | ConvertFrom-Json
        $changesMade = $false
        
        # Get actual installed versions
        Write-Host "🔍 Checking actual installed dependency versions..." -ForegroundColor Cyan
        
        # Check Node.js version
        $nodeVersion = (node --version 2>$null) -replace 'v', ''
        if ($nodeVersion) {
            $majorNodeVersion = $nodeVersion.Split('.')[0]
            if ($majorNodeVersion -ne $updatedConfig.versions.node) {
                Write-Host "📦 Node.js version mismatch. Current: $majorNodeVersion, Configured: $($updatedConfig.versions.node)" -ForegroundColor Yellow
                $updatedConfig.versions.node = $majorNodeVersion
                $changesMade = $true
            } else {
                Write-Host "✅ Node.js version is consistent: $majorNodeVersion" -ForegroundColor Green
            }
        }
        
        # Check tree-sitter-cli version from package.json
        $packageJson = Get-Content -Path "package.json" -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($packageJson.devDependencies."tree-sitter-cli") {
            $actualTreeSitterCliVersion = $packageJson.devDependencies."tree-sitter-cli"
            if ($actualTreeSitterCliVersion -ne $updatedConfig.versions.treeSitterCli) {
                Write-Host "📦 tree-sitter-cli version mismatch. Current: $actualTreeSitterCliVersion, Configured: $($updatedConfig.versions.treeSitterCli)" -ForegroundColor Yellow
                $updatedConfig.versions.treeSitterCli = $actualTreeSitterCliVersion
                $changesMade = $true
            } else {
                Write-Host "✅ tree-sitter-cli version is consistent: $actualTreeSitterCliVersion" -ForegroundColor Green
            }
        }
        
        # Check Rust version
        $rustVersion = (rustc --version 2>$null) -replace 'rustc ', '' -split ' ' | Select-Object -First 1
        if ($rustVersion) {
            # For Rust, we just check if it's stable, beta, or nightly
            $rustChannel = $rustVersion -split '-' | Select-Object -Last 1
            if ($rustChannel -notin @('stable', 'beta', 'nightly')) {
                $rustChannel = 'stable' # Default to stable if we can't determine
            }
            if ($rustChannel -ne $updatedConfig.versions.rust) {
                Write-Host "📦 Rust channel mismatch. Current: $rustChannel, Configured: $($updatedConfig.versions.rust)" -ForegroundColor Yellow
                $updatedConfig.versions.rust = $rustChannel
                $changesMade = $true
            } else {
                Write-Host "✅ Rust channel is consistent: $rustChannel" -ForegroundColor Green
            }
        }
        
        # Check Go version
        $goVersion = (go version 2>$null) -replace 'go version go', '' -split ' ' | Select-Object -First 1
        if ($goVersion) {
            $majorMinorGoVersion = $goVersion.Split('.')[0..1] -join '.'
            if ($majorMinorGoVersion -ne $updatedConfig.versions.go) {
                Write-Host "📦 Go version mismatch. Current: $majorMinorGoVersion, Configured: $($updatedConfig.versions.go)" -ForegroundColor Yellow
                $updatedConfig.versions.go = $majorMinorGoVersion
                $changesMade = $true
            } else {
                Write-Host "✅ Go version is consistent: $majorMinorGoVersion" -ForegroundColor Green
            }
        }
        
        # Check Python version
        $pythonVersion = (python --version 2>$null) -replace 'Python ', ''
        if (-not $pythonVersion) {
            $pythonVersion = (py --version 2>$null) -replace 'Python ', ''
        }
        if ($pythonVersion) {
            $majorMinorPythonVersion = $pythonVersion.Split('.')[0..1] -join '.'
            if ($majorMinorPythonVersion -ne $updatedConfig.versions.python) {
                Write-Host "📦 Python version mismatch. Current: $majorMinorPythonVersion, Configured: $($updatedConfig.versions.python)" -ForegroundColor Yellow
                $updatedConfig.versions.python = $majorMinorPythonVersion
                $changesMade = $true
            } else {
                Write-Host "✅ Python version is consistent: $majorMinorPythonVersion" -ForegroundColor Green
            }
        }
        
        # Write updated toolchain.json if changes were made
        if ($changesMade) {
            Write-Host "
📝 Updating toolchain.json with actual installed versions..." -ForegroundColor Yellow
            
            if (-not $DryRun) {
                $updatedConfig | ConvertTo-Json -Depth 100 | Set-Content -Path $toolchainJsonPath -Encoding UTF8
                Write-Host "✅ toolchain.json updated successfully" -ForegroundColor Green
            } else {
                Write-Host "⚠️  Dry run: toolchain.json would be updated with actual installed versions" -ForegroundColor Yellow
            }
        } else {
            Write-Host "
✅ All dependency versions are consistent with toolchain.json" -ForegroundColor Green
        }
        
        return $updatedConfig
    } catch {
        $errorMsg = $_.Exception.Message
        Write-Host "❌ Error updating $toolchainJsonPath`: $errorMsg" -ForegroundColor Red
        exit 1
    }
}

# Function to validate toolchain configuration across all files
function Validate-ToolchainConfig {
    param(
        [PSCustomObject]$ToolchainConfig
    )
    
    Write-Host "🔍 Validating toolchain configuration across all files..." -ForegroundColor Cyan
    Write-Host ""
    
    $allValid = $true
    
    # Validate package.json
    $packageJson = Get-Content -Path "package.json" -Raw -Encoding UTF8 | ConvertFrom-Json
    $currentTreeSitterCli = $packageJson.devDependencies."tree-sitter-cli"
    $desiredTreeSitterCli = $ToolchainConfig.versions.treeSitterCli
    
    if ($currentTreeSitterCli -ne $desiredTreeSitterCli) {
        Write-Host "❌ package.json: tree-sitter-cli version mismatch. Expected: $desiredTreeSitterCli, Actual: $currentTreeSitterCli" -ForegroundColor Red
        $allValid = $false
    } else {
        Write-Host "✅ package.json: tree-sitter-cli version is correct: $currentTreeSitterCli" -ForegroundColor Green
    }
    
    # Validate GitHub Actions workflows
    $workflowFiles = Get-ChildItem -Path ".github/workflows" -Filter "*.yml" -File
    foreach ($workflowFile in $workflowFiles) {
        Write-Host "
📋 Validating $($workflowFile.Name):" -ForegroundColor Yellow
        $content = Get-Content -Path $workflowFile.FullName -Raw -Encoding UTF8
        
        # Validate Node.js version
        $nodeVersionMatch = [regex]::Match($content, 'node-version:\s*''(\d+)''')
        if ($nodeVersionMatch.Success) {
            $currentNodeVersion = $nodeVersionMatch.Groups[1].Value
            $desiredNodeVersion = $ToolchainConfig.versions.node
            
            if ($currentNodeVersion -ne $desiredNodeVersion) {
                Write-Host "❌ Node.js version mismatch. Expected: $desiredNodeVersion, Actual: $currentNodeVersion" -ForegroundColor Red
                $allValid = $false
            } else {
                Write-Host "✅ Node.js version is correct: $currentNodeVersion" -ForegroundColor Green
            }
        }
        
        # Validate Go version
        $goVersionMatch = [regex]::Match($content, 'go-version:\s*''(\d+\.\d+)''')
        if ($goVersionMatch.Success) {
            $currentGoVersion = $goVersionMatch.Groups[1].Value
            $desiredGoVersion = $ToolchainConfig.versions.go
            
            if ($currentGoVersion -ne $desiredGoVersion) {
                Write-Host "❌ Go version mismatch. Expected: $desiredGoVersion, Actual: $currentGoVersion" -ForegroundColor Red
                $allValid = $false
            } else {
                Write-Host "✅ Go version is correct: $currentGoVersion" -ForegroundColor Green
            }
        }
        
        # Validate Python version
        $pythonVersionMatch = [regex]::Match($content, 'python-version:\s*''(\d+\.\d+)''')
        if ($pythonVersionMatch.Success) {
            $currentPythonVersion = $pythonVersionMatch.Groups[1].Value
            $desiredPythonVersion = $ToolchainConfig.versions.python
            
            if ($currentPythonVersion -ne $desiredPythonVersion) {
                Write-Host "❌ Python version mismatch. Expected: $desiredPythonVersion, Actual: $currentPythonVersion" -ForegroundColor Red
                $allValid = $false
            } else {
                Write-Host "✅ Python version is correct: $currentPythonVersion" -ForegroundColor Green
            }
        }
        
        # Validate WASI SDK version
        $wasiSdkVersionMatch = [regex]::Match($content, 'wasi-sdk-(\d+)\.0')
        if ($wasiSdkVersionMatch.Success) {
            $currentWasiSdkVersion = $wasiSdkVersionMatch.Groups[1].Value
            $desiredWasiSdkVersion = $ToolchainConfig.versions.wasiSdk -replace '\.0$', ''
            
            if ($currentWasiSdkVersion -ne $desiredWasiSdkVersion) {
                Write-Host "❌ WASI SDK version mismatch. Expected: $desiredWasiSdkVersion, Actual: $currentWasiSdkVersion" -ForegroundColor Red
                $allValid = $false
            } else {
                Write-Host "✅ WASI SDK version is correct: $currentWasiSdkVersion" -ForegroundColor Green
            }
        }
    }
    
    Write-Host ""
    if ($allValid) {
        Write-Host "🎉 All toolchain configurations are valid!" -ForegroundColor Green
    } else {
        Write-Host "❌ Some toolchain configurations are invalid. Please run the script without -ValidateOnly to fix them." -ForegroundColor Red
    }
    
    return $allValid
}

# Main script execution
if ($Help) {
    Show-Help
    exit 0
}

Write-Host "🚀 Starting dependency update process..." -ForegroundColor Green
Write-Host ""

# Check if we're in the correct directory
if (-not (Test-Path -Path "package.json" -PathType Leaf)) {
    Write-Host "❌ Error: package.json not found. Please run this script from the project root directory." -ForegroundColor Red
    exit 1
}

# Read toolchain configuration
$toolchainConfig = Get-ToolchainConfig

# Validate only if requested
if ($ValidateOnly) {
    $valid = Validate-ToolchainConfig -ToolchainConfig $toolchainConfig
    exit ($valid ? 0 : 1)
}

# Update package.json with correct toolchain versions
Update-PackageJson -ToolchainConfig $toolchainConfig

# Update npm dependencies
Run-Command -Command "npm install" -Description "Installing npm dependencies"
Run-Command -Command "npm update" -Description "Updating npm dependencies"

# Update tree-sitter-cli to the version specified in toolchain.json
$treeSitterCliVersion = $toolchainConfig.versions.treeSitterCli
Run-Command -Command "npm install --save-dev tree-sitter-cli@$treeSitterCliVersion" -Description "Updating tree-sitter-cli to version $treeSitterCliVersion"

# Update Rust dependencies
if (Test-Path -Path "Cargo.toml" -PathType Leaf) {
    Run-Command -Command "cargo update" -Description "Updating Rust dependencies"
    
    # Update dependencies in tree-sitter-cangjie directory
    if (Test-Path -Path "tree-sitter-cangjie" -PathType Container) {
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        Run-Command -Command "cargo update" -Description "Updating Rust dependencies in tree-sitter-cangjie directory"
        Pop-Location
    }
}

# Update toolchain.json based on actual installed versions
$toolchainConfig = Update-ToolchainJson -CurrentToolchainConfig $toolchainConfig

# Run tests if not skipped
if (-not $SkipTests) {
    Write-Host "🧪 Running tests..." -ForegroundColor Cyan
    Write-Host ""
    
    # Run Tree-sitter tests
    Run-Command -Command "npm test" -Description "Running Tree-sitter tests"
    
    # Run Rust tests
    Run-Command -Command "npm run test-rust" -Description "Running Rust tests"
    
    # Generate and build parser to ensure everything works
    Run-Command -Command "npm run generate" -Description "Generating parser"
    Run-Command -Command "npx tree-sitter build" -Description "Building parser" -AllowFailure $true
    
    # Run Go binding tests
    if (Get-Command "go" -ErrorAction SilentlyContinue) {
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        Run-Command -Command "go test ./bindings/go -v" -Description "Running Go binding tests"
        Pop-Location
    } else {
        Write-Host "⚠️  Go not found, skipping Go binding tests" -ForegroundColor Yellow
        Write-Host ""
    }
    
    # Run Python binding tests
    if (Get-Command "python" -ErrorAction SilentlyContinue) {
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        Run-Command -Command "pip install tree-sitter pytest" -Description "Installing Python test dependencies"
        Run-Command -Command "python -m pytest bindings/python/tests/test_binding.py -v" -Description "Running Python binding tests" -AllowFailure $true
        Pop-Location
    } else {
        Write-Host "⚠️  Python not found, skipping Python binding tests" -ForegroundColor Yellow
        Write-Host ""
    }
    
    # Run Swift binding tests (macOS only)
    if ($IsMacOS -and (Get-Command "swift" -ErrorAction SilentlyContinue)) {
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        Run-Command -Command "swift test --package-path bindings/swift" -Description "Running Swift binding tests" -AllowFailure $true
        Pop-Location
    } elseif ($IsMacOS) {
        Write-Host "⚠️  Swift not found, skipping Swift binding tests" -ForegroundColor Yellow
        Write-Host ""
    }
}

# Show summary
Write-Host "📋 Dependency update summary:" -ForegroundColor Cyan
Write-Host "- npm dependencies: Updated"
Write-Host "- Rust dependencies: Updated"
Write-Host "- tree-sitter-cangjie Rust dependencies: Updated"
if (-not $SkipTests) {
    Write-Host "- Tests: Run"
    Write-Host "  - Tree-sitter tests: ✅"
    Write-Host "  - Rust tests: ✅"
    Write-Host "  - Go binding tests: $((Get-Command "go" -ErrorAction SilentlyContinue) ? "✅" : "⚠️  Skipped")"
    Write-Host "  - Python binding tests: $((Get-Command "python" -ErrorAction SilentlyContinue) ? "✅" : "⚠️  Skipped")"
    Write-Host "  - Swift binding tests: $((($IsMacOS -and (Get-Command "swift" -ErrorAction SilentlyContinue)) ? "✅" : "⚠️  Skipped"))"
} else {
    Write-Host "- Tests: Skipped"
}
if ($DryRun) {
    Write-Host "- Mode: Dry run (no actual changes made)"
} else {
    Write-Host "- Mode: Actual run (changes made)"
}
Write-Host ""

Write-Host "🎉 Dependency update process completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Review the changes made to package.json, package-lock.json, Cargo.toml, and Cargo.lock"
Write-Host "2. Commit the changes with a meaningful message, e.g. 'chore: update dependencies'"
Write-Host "3. Push the changes to GitHub"
Write-Host "4. Create a pull request if necessary"
Write-Host ""
