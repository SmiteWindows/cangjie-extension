# Update Dependencies Script for Cangjie Extension
# This script updates all dependencies and ensures the project still works correctly

#Requires -Version 7.0

using namespace System.IO

param(
    [switch]$DryRun = $false,
    [switch]$SkipTests = $false,
    [switch]$Help = $false
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
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\update-dependencies.ps1              # Update all dependencies and run tests"
    Write-Host "  .\update-dependencies.ps1 -DryRun      # Perform a dry run"
    Write-Host "  .\update-dependencies.ps1 -SkipTests   # Update dependencies without running tests"
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

# Update npm dependencies
Run-Command -Command "npm install" -Description "Installing npm dependencies"
Run-Command -Command "npm update" -Description "Updating npm dependencies"
Run-Command -Command "npm install --save-dev tree-sitter-cli@latest" -Description "Updating tree-sitter-cli to latest version"

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
}

# Show summary
Write-Host "📋 Dependency update summary:" -ForegroundColor Cyan
Write-Host "- npm dependencies: Updated"
Write-Host "- Rust dependencies: Updated"
Write-Host "- tree-sitter-cangjie Rust dependencies: Updated"
if (-not $SkipTests) {
    Write-Host "- Tests: Run"
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
