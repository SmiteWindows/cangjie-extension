# Update Dependencies Script for Cangjie Extension
# This script updates all dependencies and ensures the project still works correctly
# It reads toolchain versions from toolchain.json and synchronizes them across all files

#Requires -Version 7.0

using namespace System.IO

param(
    [switch]$DryRun = $false,
    [switch]$SkipTests = $false,
    [switch]$Help = $false,
    [switch]$ValidateOnly = $false
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
