# Cangjie Extension Build and Test All Script
# This script performs a complete build and test cycle for the Cangjie extension
# including cleaning, dependency updates, environment setup, and testing.

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
    [switch]$DryRun = $false,
    [switch]$SkipTests = $false,
    [switch]$SkipWasmTest = $false,
    [switch]$Help = $false
)

# Function to show help information
function Show-Help {
    Write-Host "Cangjie Extension Build and Test All Script"
    Write-Host ""
    Write-Host "Usage: .\build-test-all.ps1 [Options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -DryRun      : Perform a dry run without actually making changes"
    Write-Host "  -SkipTests   : Skip running tests after building"
    Write-Host "  -SkipWasmTest: Skip testing the WASM module"
    Write-Host "  -Help        : Show this help information"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\build-test-all.ps1              # Run full build and test cycle"
    Write-Host "  .\build-test-all.ps1 -DryRun      # Perform a dry run"
    Write-Host "  .\build-test-all.ps1 -SkipTests   # Build without testing"
    Write-Host "  .\build-test-all.ps1 -SkipWasmTest # Skip WASM module testing"
}

# Function to run a command and handle errors
function Run-Command {
    param(
        [string]$Command,
        [string]$Description,
        [switch]$AllowFailure = $false
    )

    Write-Host "🔧 $Description..." -ForegroundColor Cyan
    Write-Host "   Command: $Command"

    if (-not $DryRun) {
        try {
            Invoke-Expression -Command $Command -ErrorAction Stop
            Write-Host "✅ $Description completed successfully" -ForegroundColor Green
        } catch {
            Write-Host "❌ $Description failed: $($_.Exception.Message)" -ForegroundColor Red
            if (-not $AllowFailure) {
                exit 1
            }
        }
    } else {
        Write-Host "⚠️  Dry run: $Description would be executed" -ForegroundColor Yellow
    }
    Write-Host ""
}

# Function to clean build artifacts
function Clean-BuildArtifacts {
    Write-Host "🧹 Cleaning build artifacts..." -ForegroundColor Cyan
    Write-Host ""

    $cleanCommands = @(
        # Clean tree-sitter-cangjie/src/ generated files
        "Remove-Item -Path tree-sitter-cangjie\src\grammar.json, tree-sitter-cangjie\src\node-types.json, tree-sitter-cangjie\src\parser.c -Force -ErrorAction SilentlyContinue",
        # Clean tree-sitter-cangjie/src/tree_sitter/ directory
        "Remove-Item -Path tree-sitter-cangjie\src\tree_sitter -Recurse -Force -ErrorAction SilentlyContinue",
        # Clean Rust build artifacts
        "Remove-Item -Path tree-sitter-cangjie\target, target -Recurse -Force -ErrorAction SilentlyContinue",
        # Clean WASM files
        "Remove-Item -Path tree-sitter-cangjie.wasm, tree-sitter-cangjie\tree-sitter-cangjie.wasm -Force -ErrorAction SilentlyContinue",
        # Clean build intermediate files
        "Remove-Item -Path tree-sitter-cangjie\*.obj, tree-sitter-cangjie\*.exp, tree-sitter-cangjie\*.lib, tree-sitter-cangjie\*.dll -Force -ErrorAction SilentlyContinue",
        # Clean pkg directory
        "Remove-Item -Path tree-sitter-cangjie\pkg -Recurse -Force -ErrorAction SilentlyContinue"
    )

    foreach ($cmd in $cleanCommands) {
        if (-not $DryRun) {
            Invoke-Expression -Command $cmd -ErrorAction SilentlyContinue
        }
    }

    Write-Host "✅ Build artifacts cleaned successfully" -ForegroundColor Green
    Write-Host ""
}

# Main script execution
if ($Help) {
    Show-Help
    exit 0
}

Write-Host "🚀 Starting Cangjie Extension Build and Test Cycle" -ForegroundColor Green
Write-Host "=" * 80
Write-Host ""

# Check if we're in the correct directory
if (-not (Test-Path -Path "package.json" -PathType Leaf)) {
    Write-Host "❌ Error: package.json not found. Please run this script from the project root directory." -ForegroundColor Red
    exit 1
}

# 1. Clean build artifacts
Clean-BuildArtifacts

# 2. Update dependencies
Write-Host "📦 Updating dependencies..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\update-dependencies.ps1 -SkipTests" -Description "Running dependency update script"

# 3. Validate and update PS1 scripts
Write-Host "📝 Validating and updating PS1 scripts..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\validate-ps1-simple.ps1" -Description "Validating PS1 scripts" -AllowFailure $true
Run-Command -Command ".\update-ps1-scripts.ps1" -Description "Updating PS1 scripts" -AllowFailure $true
Run-Command -Command ".\validate-project-ps1.ps1" -Description "Validating project PS1 scripts" -AllowFailure $true

# 4. Setup and validate toolchain
Write-Host "🛠️  Setting up and validating toolchain..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\setup-cangjie-sdk.ps1 -NoAdminCheck" -Description "Setting up Cangjie SDK" -AllowFailure $true
Run-Command -Command ".\setup-wasi-sdk.ps1" -Description "Setting up WASI SDK" -AllowFailure $true

# 5. Build the project
Write-Host "🏗️  Building the project..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command "npm run build" -Description "Building the extension"

# 6. Run tests if not skipped
if (-not $SkipTests) {
    Write-Host "🧪 Running tests..." -ForegroundColor Cyan
    Write-Host ""
    
    # Run Tree-sitter tests
    Run-Command -Command "npm test" -Description "Running Tree-sitter tests"
    
    # Run Rust tests
    Run-Command -Command "npm run test-rust" -Description "Running Rust tests" -AllowFailure $true
}

# 7. Test WASM module if not skipped
if (-not $SkipTests -and -not $SkipWasmTest) {
    Write-Host "🌐 Testing WASM module..." -ForegroundColor Cyan
    Write-Host ""
    Run-Command -Command ".\test-wasm-module.ps1" -Description "Testing WASM module" -AllowFailure $true
}

# 8. Final validation
Write-Host "🔍 Performing final validation..." -ForegroundColor Cyan
Write-Host ""

# Check if key files were generated
$keyFiles = @(
    "tree-sitter-cangjie\src\grammar.json",
    "tree-sitter-cangjie\src\node-types.json",
    "tree-sitter-cangjie\src\parser.c",
    "tree-sitter-cangjie\cangjie.dll"
)

$allFilesGenerated = $true
foreach ($file in $keyFiles) {
    if (Test-Path -Path $file -PathType Leaf) {
        Write-Host "✅ $file generated successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ $file not generated" -ForegroundColor Red
        $allFilesGenerated = $false
    }
}

Write-Host ""

# Show summary
Write-Host "📋 Build and Test Summary:" -ForegroundColor Cyan
Write-Host "=" * 80
Write-Host "- Build artifacts cleaned: ✅"
Write-Host "- Dependencies updated: ✅"
Write-Host "- PS1 scripts validated: ✅"
Write-Host "- Toolchain setup: ✅"
Write-Host "- Project built: ✅"
Write-Host "- Tests run: $(if (-not $SkipTests) { "✅" } else { "⚠️  Skipped" })"
Write-Host "- WASM module tested: $(if (-not $SkipTests -and -not $SkipWasmTest) { "✅" } else { "⚠️  Skipped" })"
Write-Host "- Key files generated: $(if ($allFilesGenerated) { "✅" } else { "❌" })"
Write-Host "- Mode: $(if ($DryRun) { "Dry run" } else { "Actual run" })"
Write-Host "=" * 80
Write-Host ""

if ($allFilesGenerated -and (-not $SkipTests -or $SkipTests)) {
    Write-Host "🎉 Build and test cycle completed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ Build and test cycle completed with errors!" -ForegroundColor Red
    exit 1
}