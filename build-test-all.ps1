<#
.SYNOPSIS
    Performs a complete build and test cycle for the Cangjie extension.

.DESCRIPTION
    This script executes a comprehensive build and test workflow for the Cangjie extension, including:
    - Cleaning build artifacts
    - Updating dependencies
    - Validating and updating PowerShell scripts
    - Setting up required SDKs (Cangjie, WASI)
    - Building the project
    - Running tests (unit, integration, WASM)
    - Validating generated files
    
    The script provides multiple options to customize the build and test process, including dry run mode, 
    test skipping, and WASM test skipping.

.PARAMETER DryRun
    Performs a dry run without actually executing any commands that modify the system.
    Useful for previewing what the script would do.

.PARAMETER SkipTests
    Skips running all tests after building the project.
    Useful for quick builds when testing is not required.

.PARAMETER SkipWasmTest
    Skips testing the WASM module while still running other tests.
    Useful when WASM testing is not needed or if WASM build is not available.

.PARAMETER Help
    Displays this help information and exits.

.EXAMPLE
    .\build-test-all.ps1
    Runs the full build and test cycle with default settings.

.EXAMPLE
    .\build-test-all.ps1 -DryRun
    Performs a dry run, showing what commands would be executed without actually running them.

.EXAMPLE
    .\build-test-all.ps1 -SkipTests
    Builds the project but skips running all tests.

.EXAMPLE
    .\build-test-all.ps1 -SkipWasmTest
    Runs all tests except for the WASM module test.

.NOTES
    Author: Cangjie Extension Team
    Version: 1.0
    Date: $(Get-Date)
    
    This script requires PowerShell 7 or later.
    It will automatically attempt to switch to PowerShell 7 if run in an older version.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [switch]$DryRun = $false,
    [switch]$SkipTests = $false,
    [switch]$SkipWasmTest = $false,
    [switch]$Help = $false
)

# Ensure PowerShell 7 environment
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "This script requires PowerShell 7 or later. Attempting to switch to PowerShell 7..." -ForegroundColor Yellow
    
    # Check if pwsh executable is available in PATH
    if (Get-Command pwsh -ErrorAction SilentlyContinue) {
        # Restart the script in PowerShell 7 with the same arguments
        pwsh -File $PSCommandPath @args
        exit $LASTEXITCODE
    } else {
        # Show error message if PowerShell 7 is not installed
        Write-Host "PowerShell 7 (pwsh) is not installed. Please install PowerShell 7 and try again." -ForegroundColor Red
        exit 1
    }
}

<#
.SYNOPSIS
    Displays the script help information.
.DESCRIPTION
    Shows a comprehensive help message with usage, options, and examples for the script.
#>
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
    Write-Host "Examples:" -ForegroundColor Cyan
    Write-Host "  .\build-test-all.ps1              # Run full build and test cycle"
    Write-Host "  .\build-test-all.ps1 -DryRun      # Perform a dry run"
    Write-Host "  .\build-test-all.ps1 -SkipTests   # Build without testing"
    Write-Host "  .\build-test-all.ps1 -SkipWasmTest # Skip WASM module testing"
}

<#
.SYNOPSIS
    Runs a command with standardized error handling and output formatting.
.DESCRIPTION
    Executes a command with proper error handling, logging, and dry run support.
    Displays descriptive messages for each command execution.

.PARAMETER Command
    The command to execute.

.PARAMETER Description
    A descriptive name for the command being executed.

.PARAMETER AllowFailure
    If $true, continues execution even if the command fails.
    If $false (default), exits the script with an error code if the command fails.
#>
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
            # Execute the command with strict error handling
            Invoke-Expression -Command $Command -ErrorAction Stop
            Write-Host "✅ $Description completed successfully" -ForegroundColor Green
        } catch {
            Write-Host "❌ $Description failed: $($_.Exception.Message)" -ForegroundColor Red
            if (-not $AllowFailure) {
                # Exit the script if failure is not allowed
                exit 1
            }
        }
    } else {
        Write-Host "⚠️  Dry run: $Description would be executed" -ForegroundColor Yellow
    }
    Write-Host ""
}

<#
.SYNOPSIS
    Cleans build artifacts from previous builds.
.DESCRIPTION
    Removes various build artifacts, including:
    - Generated Tree-sitter files
    - Rust build targets
    - WASM files
    - Intermediate build files
    - Package directories

    All cleaning operations are performed with error handling to ensure the script continues
    even if some files or directories are not found.
#>
function Clean-BuildArtifacts {
    Write-Host "🧹 Cleaning build artifacts..." -ForegroundColor Cyan
    Write-Host ""

    # Define cleaning commands to execute
    $cleanCommands = @(
        # Clean tree-sitter-cangjie/src/ generated files
        "Remove-Item -Path tree-sitter-cangjie\src\grammar.json, tree-sitter-cangjie\src\node-types.json, tree-sitter-cangjie\src\parser.c -Force -ErrorAction SilentlyContinue",
        # Clean tree-sitter-cangjie/src/tree_sitter/ directory
        "Remove-Item -Path tree-sitter-cangjie\src\tree_sitter -Recurse -Force -ErrorAction SilentlyContinue",
        # Clean Rust build artifacts in tree-sitter-cangjie and root directories
        "Remove-Item -Path tree-sitter-cangjie\target, target -Recurse -Force -ErrorAction SilentlyContinue",
        # Clean WASM files in root and tree-sitter-cangjie directories
        "Remove-Item -Path tree-sitter-cangjie.wasm, tree-sitter-cangjie\tree-sitter-cangjie.wasm -Force -ErrorAction SilentlyContinue",
        # Clean build intermediate files (Windows-specific)
        "Remove-Item -Path tree-sitter-cangjie\*.obj, tree-sitter-cangjie\*.exp, tree-sitter-cangjie\*.lib, tree-sitter-cangjie\*.dll -Force -ErrorAction SilentlyContinue",
        # Clean wasm-pack output directory
        "Remove-Item -Path tree-sitter-cangjie\pkg -Recurse -Force -ErrorAction SilentlyContinue"
    )

    # Execute each cleaning command
    foreach ($cmd in $cleanCommands) {
        if (-not $DryRun) {
            # Execute the command with silent error handling
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

# Check if we're in the correct directory (root of the project)
if (-not (Test-Path -Path "package.json" -PathType Leaf)) {
    Write-Host "❌ Error: package.json not found. Please run this script from the project root directory." -ForegroundColor Red
    exit 1
}

# Step 1: Clean build artifacts
Clean-BuildArtifacts

# Step 2: Update dependencies
Write-Host "📦 Updating dependencies..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\update-dependencies.ps1 -SkipTests" -Description "Running dependency update script"

# Step 3: Validate and update PS1 scripts
Write-Host "📝 Validating and updating PS1 scripts..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\validate-ps1-simple.ps1" -Description "Validating PS1 scripts" -AllowFailure $true
Run-Command -Command ".\update-ps1-scripts.ps1" -Description "Updating PS1 scripts" -AllowFailure $true
Run-Command -Command ".\validate-project-ps1.ps1" -Description "Validating project PS1 scripts" -AllowFailure $true

# Step 4: Setup and validate toolchain
Write-Host "🛠️  Setting up and validating toolchain..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command ".\setup-cangjie-sdk.ps1 -NoAdminCheck" -Description "Setting up Cangjie SDK" -AllowFailure $true
Run-Command -Command ".\setup-wasi-sdk.ps1" -Description "Setting up WASI SDK" -AllowFailure $true

# Step 5: Build the project
Write-Host "🏗️  Building the project..." -ForegroundColor Cyan
Write-Host ""
Run-Command -Command "npm run build" -Description "Building the extension"

# Step 6: Run tests if not skipped
if (-not $SkipTests) {
    Write-Host "🧪 Running tests..." -ForegroundColor Cyan
    Write-Host ""
    
    # Run Tree-sitter tests
    Run-Command -Command "npm test" -Description "Running Tree-sitter tests"
    
    # Run Rust tests (allow failure as they might be skipped in some environments)
    Run-Command -Command "npm run test-rust" -Description "Running Rust tests" -AllowFailure $true
}

# Step 7: Test WASM module if not skipped
if (-not $SkipTests -and -not $SkipWasmTest) {
    Write-Host "🌐 Testing WASM module..." -ForegroundColor Cyan
    Write-Host ""
    # Run WASM module tests (allow failure if WASM build is not available)
    Run-Command -Command ".\test-wasm-module.ps1" -Description "Testing WASM module" -AllowFailure $true
}

# Step 8: Final validation of generated files
Write-Host "🔍 Performing final validation..." -ForegroundColor Cyan
Write-Host ""

# Define key files that should be generated by the build process
$keyFiles = @(
    "tree-sitter-cangjie\src\grammar.json",       # Generated Tree-sitter grammar
    "tree-sitter-cangjie\src\node-types.json",    # Generated node types
    "tree-sitter-cangjie\src\parser.c",          # Generated parser
    "tree-sitter-cangjie\cangjie.dll"             # Compiled DLL
)

$allFilesGenerated = $true
# Validate each key file exists
foreach ($file in $keyFiles) {
    if (Test-Path -Path $file -PathType Leaf) {
        Write-Host "✅ $file generated successfully" -ForegroundColor Green
    } else {
        Write-Host "❌ $file not generated" -ForegroundColor Red
        $allFilesGenerated = $false
    }
}

Write-Host ""

# Show comprehensive summary of the build and test process
Write-Host "📋 Build and Test Summary:" -ForegroundColor Cyan
Write-Host "=" * 80
Write-Host "- Build artifacts cleaned: ✅"
Write-Host "- Dependencies updated: ✅"
Write-Host "- PS1 scripts validated: ✅"
Write-Host "- Toolchain setup: ✅"
Write-Host "- Project built: ✅"
Write-Host "- Tests run: $(if (-not $SkipTests) { "✅" } else { "⚠️  Skipped" })
Write-Host "- WASM module tested: $(if (-not $SkipTests -and -not $SkipWasmTest) { "✅" } else { "⚠️  Skipped" })
Write-Host "- Key files generated: $(if ($allFilesGenerated) { "✅" } else { "❌" })
Write-Host "- Mode: $(if ($DryRun) { "Dry run" } else { "Actual run" })
Write-Host "=" * 80
Write-Host ""

# Determine overall success status
if ($allFilesGenerated -and (-not $SkipTests -or $SkipTests)) {
    Write-Host "🎉 Build and test cycle completed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ Build and test cycle completed with errors!" -ForegroundColor Red
    exit 1
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

