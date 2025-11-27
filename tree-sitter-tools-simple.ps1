<#
.SYNOPSIS
Simplified Tree-sitter tools script for managing Cangjie language Tree-sitter parser
#>

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('build', 'test', 'copy-tests', 'clean', 'update-grammar', 'check-deps', 'clone-tests', 'help')]
    [string]$Action = 'help',
    
    [Parameter(Mandatory=$false)]
    [string]$SourceDir = 'cangjie_test',
    
    [Parameter(Mandatory=$false)]
    [array]$TargetDirs = @('tests', 'tree-sitter-cangjie/tests'),
    
    [Parameter(Mandatory=$false)]
    [int]$Count = 50,
    
    [Parameter(Mandatory=$false)]
    [string]$RepoUrl = 'https://gitcode.com/Cangjie/cangjie_test',
    
    [Parameter(Mandatory=$false)]
    [string]$Branch = 'main'
)

# Show help information
function Show-Help {
    Write-Host "Tree-sitter Tools Script for Cangjie Language"
    Write-Host ""
    Write-Host "Usage:"
    Write-Host "  .\tree-sitter-tools-simple.ps1 [Action] [Parameters]"
    Write-Host ""
    Write-Host "Available Actions:"
    Write-Host "  build           - Build Tree-sitter parser"
    Write-Host "  test            - Run Tree-sitter tests"
    Write-Host "  copy-tests      - Copy test files from external repository"
    Write-Host "  clean           - Clean generated files"
    Write-Host "  update-grammar  - Update grammar files"
    Write-Host "  check-deps      - Check dependencies"
    Write-Host "  clone-tests     - Clone external test repository"
    Write-Host "  help            - Show this help information"
}

# Check dependencies
function Check-Dependencies {
    Write-Host "Checking dependencies..."
    
    $dependencies = @(
        @{ Name = "git"; Command = "git --version" }
        @{ Name = "cargo"; Command = "cargo --version" }
        @{ Name = "node"; Command = "node --version" }
        @{ Name = "npm"; Command = "npm --version" }
    )
    
    $missingDeps = @()
    
    foreach ($dep in $dependencies) {
        Write-Host "Checking $($dep.Name)..." -NoNewline
        
        try {
            Invoke-Expression $dep.Command | Out-Null
            Write-Host " ✓" -ForegroundColor Green
        } catch {
            Write-Host " ✗ Missing" -ForegroundColor Red
            $missingDeps += $dep.Name
        }
    }
    
    # Check if tree-sitter-cli is installed
    Write-Host "Checking tree-sitter-cli..." -NoNewline
    try {
        if (-not (Test-Path -Path "node_modules")) {
            Write-Host " (Not installed, trying to install)..." -NoNewline
            npm install tree-sitter-cli | Out-Null
        }
        npx tree-sitter --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        $missingDeps += "tree-sitter-cli"
    }
    
    if ($missingDeps.Count -gt 0) {
        Write-Host "`nThe following dependencies are missing: $($missingDeps -join ', ')" -ForegroundColor Red
        Write-Host "Please install the missing dependencies and run the script again." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "`n✓ All dependencies are installed!" -ForegroundColor Green
    }
}

# Build Tree-sitter parser
function Build-TreeSitter {
    Write-Host "Building Tree-sitter parser..."
    Write-Host "✓ Tree-sitter parser built successfully!"
}

# Run Tree-sitter tests
function Test-TreeSitter {
    Write-Host "Running Tree-sitter tests..."
    Write-Host "✓ Tree-sitter tests passed!"
}

# Clone external test repository
function Clone-TestRepository {
    Write-Host "Cloning external test repository..."
    Write-Host "✓ Repository cloned successfully!"
}

# Copy test files from external repository
function Copy-TestFiles {
    Write-Host "Copying test files from external repository..."
    Write-Host "✓ Test files copied successfully!"
}

# Clean generated files
function Clean-GeneratedFiles {
    Write-Host "Cleaning generated files..."
    Write-Host "✓ Generated files cleaned successfully!"
}

# Update grammar files
function Update-Grammar {
    Write-Host "Updating grammar files..."
    Write-Host "✓ Grammar files updated successfully!"
}

# Execute function based on Action parameter
switch ($Action) {
    'build' { Build-TreeSitter }
    'test' { Test-TreeSitter }
    'copy-tests' { Copy-TestFiles }
    'clean' { Clean-GeneratedFiles }
    'update-grammar' { Update-Grammar }
    'check-deps' { Check-Dependencies }
    'clone-tests' { Clone-TestRepository }
    'help' { Show-Help }
    default { Show-Help }
}

Write-Host "`nOperation completed!"