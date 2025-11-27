# Simple Tree-sitter Management Script
# Version: 1.0
# This script provides basic functionality for managing the Cangjie Tree-sitter parser

Write-Host "Tree-sitter Simple Manager for Cangjie"
Write-Host "========================================="
Write-Host ""

# Function to check if a command exists
function Command-Exists($cmd) {
    $result = Get-Command $cmd -ErrorAction SilentlyContinue
    return $result -ne $null
}

# Function to build the parser
function Build-Parser {
    Write-Host "Building Tree-sitter Parser..."
    Set-Location -Path "tree-sitter-cangjie"
    cargo build --release
    npx tree-sitter build --wasm
    Copy-Item -Path "*.wasm" -Destination ".." -Force
    Set-Location -Path ".."
    Write-Host "Build completed!" -ForegroundColor Green
}

# Function to run tests
function Run-Tests {
    Write-Host "Running Tests..."
    Set-Location -Path "tree-sitter-cangjie"
    cargo test
    npx tree-sitter test
    Set-Location -Path ".."
    Write-Host "Tests completed!" -ForegroundColor Green
}

# Function to copy test files
function Copy-TestFiles {
    Write-Host "Copying Test Files..."
    $sourceDir = "cangjie_test"
    $targetDirs = @("tests", "tree-sitter-cangjie/tests")
    
    # Check if source directory exists
    if (-not (Test-Path -Path $sourceDir)) {
        Write-Host "Source directory $sourceDir not found!" -ForegroundColor Red
        return
    }
    
    # Get all cj files
    $allFiles = Get-ChildItem -Path $sourceDir -Filter "*.cj" -Recurse
    if ($allFiles.Count -eq 0) {
        Write-Host "No .cj files found in $sourceDir!" -ForegroundColor Red
        return
    }
    
    # Copy files to each target directory
    foreach ($dir in $targetDirs) {
        # Create directory if needed
        if (-not (Test-Path -Path $dir)) {
            New-Item -Path $dir -ItemType Directory -Force | Out-Null
        }
        
        # Copy random files
        $randomFiles = $allFiles | Get-Random -Count 50
        $counter = 0
        
        foreach ($file in $randomFiles) {
            $counter++
            $newName = "test_$(Get-Date -Format 'yyyyMMdd_HHmmss')_${counter}.cj"
            $destPath = Join-Path $dir $newName
            Copy-Item -Path $file.FullName -Destination $destPath -Force
        }
        
        Write-Host "Copied 50 files to $dir" -ForegroundColor Green
    }
    
    Write-Host "Test files copied!" -ForegroundColor Green
}

# Function to clean generated files
function Clean-Files {
    Write-Host "Cleaning Generated Files..."
    
    # Clean WASM files in root
    if (Test-Path -Path "*.wasm") {
        Remove-Item -Path "*.wasm" -Force
    }
    
    # Clean tree-sitter-cangjie directory
    if (Test-Path -Path "tree-sitter-cangjie") {
        Set-Location -Path "tree-sitter-cangjie"
        
        if (Test-Path -Path "target") {
            Remove-Item -Path "target" -Recurse -Force
        }
        
        if (Test-Path -Path "*.wasm") {
            Remove-Item -Path "*.wasm" -Force
        }
        
        Set-Location -Path ".."
    }
    
    Write-Host "Files cleaned!" -ForegroundColor Green
}

# Function to update grammar
function Update-Grammar {
    Write-Host "Updating Grammar..."
    Set-Location -Path "tree-sitter-cangjie"
    npx tree-sitter generate
    Set-Location -Path ".."
    Write-Host "Grammar updated!" -ForegroundColor Green
}

# Function to check dependencies
function Check-Dependencies {
    Write-Host "Checking Dependencies..."
    
    $deps = @("git", "cargo", "node", "npm")
    $allGood = $true
    
    foreach ($dep in $deps) {
        Write-Host "Checking $dep..." -NoNewline
        if (Command-Exists $dep) {
            Write-Host " ✓" -ForegroundColor Green
        } else {
            Write-Host " ✗" -ForegroundColor Red
            $allGood = $false
        }
    }
    
    # Check tree-sitter-cli
    Write-Host "Checking tree-sitter-cli..." -NoNewline
    if (-not (Test-Path -Path "node_modules")) {
        Write-Host " (Installing)..." -NoNewline
        npm install tree-sitter-cli -q | Out-Null
    }
    
    try {
        npx tree-sitter --version | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗" -ForegroundColor Red
        $allGood = $false
    }
    
    if ($allGood) {
        Write-Host "All dependencies are installed!" -ForegroundColor Green
    } else {
        Write-Host "Some dependencies are missing!" -ForegroundColor Red
    }
}

# Function to clone test repository
function Clone-TestRepo {
    Write-Host "Cloning Test Repository..."
    $repoUrl = "https://gitcode.com/Cangjie/cangjie_test"
    $targetDir = "cangjie_test"
    
    if (Test-Path -Path $targetDir) {
        Write-Host "Directory $targetDir already exists. Updating..."
        Set-Location -Path $targetDir
        git pull origin main
        Set-Location -Path ".."
    } else {
        git clone --branch main $repoUrl $targetDir
    }
    
    Write-Host "Repository cloned/updated!" -ForegroundColor Green
}

# Main menu
Write-Host "Available Commands:"
Write-Host "1. Build Parser"
Write-Host "2. Run Tests"
Write-Host "3. Copy Test Files"
Write-Host "4. Clean Files"
Write-Host "5. Update Grammar"
Write-Host "6. Check Dependencies"
Write-Host "7. Clone Test Repo"
Write-Host "0. Exit"
Write-Host ""

# Get user input
$choice = Read-Host "Enter your choice (0-7)"
Write-Host ""

# Execute command
switch ($choice) {
    "1" { Build-Parser }
    "2" { Run-Tests }
    "3" { Copy-TestFiles }
    "4" { Clean-Files }
    "5" { Update-Grammar }
    "6" { Check-Dependencies }
    "7" { Clone-TestRepo }
    "0" { exit 0 }
    default { Write-Host "Invalid choice!" -ForegroundColor Red }
}

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Green