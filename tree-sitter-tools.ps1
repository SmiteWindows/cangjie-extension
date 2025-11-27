# Tree-sitter Tools Script for Cangjie Language

param(
    [string]$Action = "help",
    [string]$SourceDir = "cangjie_test",
    [array]$TargetDirs = @("tests", "tree-sitter-cangjie/tests"),
    [int]$Count = 50,
    [string]$RepoUrl = "https://gitcode.com/Cangjie/cangjie_test",
    [string]$Branch = "main"
)

# Function to show help information
function Show-Help {
    Write-Host "Tree-sitter Tools Script for Cangjie Language"
    Write-Host ""
    Write-Host "Usage: .\tree-sitter-tools.ps1 [Action] [Parameters]"
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
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -Action         - Action to perform (default: help)"
    Write-Host "  -SourceDir      - Source directory for test files (default: cangjie_test)"
    Write-Host "  -TargetDirs     - Target directories for test files (default: tests, tree-sitter-cangjie/tests)"
    Write-Host "  -Count          - Number of test files to copy (default: 50)"
    Write-Host "  -RepoUrl        - Git URL for test repository (default: https://gitcode.com/Cangjie/cangjie_test)"
    Write-Host "  -Branch         - Branch for test repository (default: main)"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\tree-sitter-tools.ps1 -Action build"
    Write-Host "  .\tree-sitter-tools.ps1 -Action test"
    Write-Host "  .\tree-sitter-tools.ps1 -Action copy-tests -Count 100"
}

# Function to check dependencies
function Check-Dependencies {
    Write-Host "Checking dependencies..."
    
    # Check if git is installed
    Write-Host "Checking git..." -NoNewline
    try {
        git --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        exit 1
    }
    
    # Check if cargo is installed
    Write-Host "Checking cargo..." -NoNewline
    try {
        cargo --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        exit 1
    }
    
    # Check if node is installed
    Write-Host "Checking node..." -NoNewline
    try {
        node --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        exit 1
    }
    
    # Check if npm is installed
    Write-Host "Checking npm..." -NoNewline
    try {
        npm --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        exit 1
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
        exit 1
    }
    
    Write-Host "All dependencies are installed!" -ForegroundColor Green
}

# Function to build Tree-sitter parser
function Build-TreeSitter {
    Write-Host "Building Tree-sitter parser..."
    
    # Change to tree-sitter-cangjie directory
    Set-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
    
    # Build Rust bindings
    Write-Host "Building Rust bindings..."
    cargo build --release
    
    # Build WASM
    Write-Host "Building WASM..."
    npx tree-sitter build --wasm
    
    # Copy WASM to main directory
    Copy-Item -Path "*.wasm" -Destination ".." -Force
    
    # Change back to original directory
    Set-Location -Path ".." -ErrorAction SilentlyContinue
    
    Write-Host "Tree-sitter parser built successfully!" -ForegroundColor Green
}

# Function to run Tree-sitter tests
function Test-TreeSitter {
    Write-Host "Running Tree-sitter tests..."
    
    # Change to tree-sitter-cangjie directory
    Set-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
    
    # Run Rust tests
    Write-Host "Running Rust tests..."
    cargo test
    
    # Run Tree-sitter CLI tests
    Write-Host "Running Tree-sitter CLI tests..."
    npx tree-sitter test
    
    # Change back to original directory
    Set-Location -Path ".." -ErrorAction SilentlyContinue
    
    Write-Host "Tree-sitter tests passed!" -ForegroundColor Green
}

# Function to clone external test repository
function Clone-TestRepository {
    Write-Host "Cloning external test repository..."
    
    # Check if source directory already exists
    if (Test-Path -Path $SourceDir -PathType Container) {
        Write-Host "Source directory $SourceDir already exists. Update? (y/n): " -NoNewline
        $response = Read-Host
        if ($response -eq "y" -or $response -eq "Y") {
            Write-Host "Updating existing repository..."
            Set-Location -Path $SourceDir -ErrorAction Stop
            git pull origin $Branch
            Set-Location -Path ".." -ErrorAction SilentlyContinue
            Write-Host "Repository updated successfully!" -ForegroundColor Green
        } else {
            Write-Host "Skipping clone operation."
            return
        }
    } else {
        # Clone new repository
        Write-Host "Cloning repository $RepoUrl to $SourceDir..."
        git clone --branch $Branch $RepoUrl $SourceDir
        Write-Host "Repository cloned successfully!" -ForegroundColor Green
    }
}

# Function to copy test files from external repository
function Copy-TestFiles {
    Write-Host "Copying test files from external repository..."
    
    # Check if source directory exists
    if (-not (Test-Path -Path $SourceDir -PathType Container)) {
        Write-Host "Source directory $SourceDir does not exist" -ForegroundColor Red
        exit 1
    }
    
    # Get all *.cj file paths
    $allCjFiles = Get-ChildItem -Path $SourceDir -Filter *.cj -Recurse | Select-Object -ExpandProperty FullName
    
    if ($allCjFiles.Count -eq 0) {
        Write-Host "No *.cj files found in source directory" -ForegroundColor Red
        exit 1
    }
    
    # Copy files to each target directory
    foreach ($dir in $TargetDirs) {
        # Ensure target directory exists
        if (-not (Test-Path -Path $dir -PathType Container)) {
            Write-Host "Creating directory $dir..."
            New-Item -Path $dir -ItemType Directory -Force | Out-Null
        }
        
        Write-Host "Copying files to $dir..."
        $randomFiles = $allCjFiles | Get-Random -Count $Count
        $counter = 0
        $successCount = 0
        $failedCount = 0
        
        foreach ($file in $randomFiles) {
            $counter++
            $newName = "test_$(Get-Date -Format 'yyyyMMdd_HHmmss')_$counter.cj"
            $destPath = Join-Path $dir $newName
            
            try {
                Copy-Item -Path $file -Destination $destPath -Force
                Write-Host "Copied $file to $destPath"
                $successCount++
            } catch {
                Write-Host "Failed to copy $file to $destPath - $_" -ForegroundColor Red
                $failedCount++
            }
        }
        
        Write-Host "Finished copying to ${dir}: ${successCount} succeeded, ${failedCount} failed"
    }
    
    Write-Host "Test files copied successfully!" -ForegroundColor Green
}

# Function to clean generated files
function Clean-GeneratedFiles {
    Write-Host "Cleaning generated files..."
    
    # Clean WASM files in main directory
    if (Test-Path -Path "*.wasm") {
        Write-Host "Cleaning WASM files in main directory..."
        Remove-Item -Path "*.wasm" -Force
    }
    
    # Clean generated files in tree-sitter-cangjie directory
    if (Test-Path -Path "tree-sitter-cangjie") {
        Set-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        
        # Clean target directory
        if (Test-Path -Path "target") {
            Write-Host "Cleaning target directory..."
            Remove-Item -Path "target" -Recurse -Force
        }
        
        # Clean WASM files
        if (Test-Path -Path "*.wasm") {
            Write-Host "Cleaning WASM files..."
            Remove-Item -Path "*.wasm" -Force
        }
        
        Set-Location -Path ".." -ErrorAction SilentlyContinue
    }
    
    Write-Host "Generated files cleaned successfully!" -ForegroundColor Green
}

# Function to update grammar files
function Update-Grammar {
    Write-Host "Updating grammar files..."
    
    # Change to tree-sitter-cangjie directory
    Set-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
    
    # Generate grammar files
    Write-Host "Generating grammar files..."
    npx tree-sitter generate
    
    # Change back to original directory
    Set-Location -Path ".." -ErrorAction SilentlyContinue
    
    Write-Host "Grammar files updated successfully!" -ForegroundColor Green
}

# Main script execution
switch ($Action) {
    "build" {
        Build-TreeSitter
    }
    "test" {
        Test-TreeSitter
    }
    "copy-tests" {
        Copy-TestFiles
    }
    "clean" {
        Clean-GeneratedFiles
    }
    "update-grammar" {
        Update-Grammar
    }
    "check-deps" {
        Check-Dependencies
    }
    "clone-tests" {
        Clone-TestRepository
    }
    "help" {
        Show-Help
    }
    default {
        Show-Help
    }
}

Write-Host "Operation completed!"