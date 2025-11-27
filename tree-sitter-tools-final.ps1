# Tree-sitter Tools Script for Cangjie Language
# Version: 1.0
# Description: A comprehensive script to manage Cangjie language Tree-sitter parser

# Main function to show help
function Show-Help {
    Write-Host "Tree-sitter Tools Script for Cangjie Language"
    Write-Host "Version: 1.0"
    Write-Host ""
    Write-Host "Usage: .\tree-sitter-tools-final.ps1 [action]"
    Write-Host ""
    Write-Host "Available Actions:"
    Write-Host "  help            - Show this help information"
    Write-Host "  build           - Build Tree-sitter parser"
    Write-Host "  test            - Run Tree-sitter tests"
    Write-Host "  copy-tests      - Copy test files from external repository"
    Write-Host "  clean           - Clean generated files"
    Write-Host "  update-grammar  - Update grammar files"
    Write-Host "  check-deps      - Check dependencies"
    Write-Host "  clone-tests     - Clone external test repository"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\tree-sitter-tools-final.ps1 help"
    Write-Host "  .\tree-sitter-tools-final.ps1 build"
    Write-Host "  .\tree-sitter-tools-final.ps1 test"
}

# Function to check dependencies
function Check-Dependencies {
    Write-Host "Checking dependencies..."
    
    # List of dependencies to check
    $deps = @("git", "cargo", "node", "npm")
    $allInstalled = $true
    
    # Check each dependency
    foreach ($dep in $deps) {
        Write-Host "Checking $dep..." -NoNewline
        try {
            $result = Invoke-Expression "$dep --version" -ErrorAction Stop
            Write-Host " ✓" -ForegroundColor Green
        } catch {
            Write-Host " ✗ Missing" -ForegroundColor Red
            $allInstalled = $false
        }
    }
    
    # Check tree-sitter-cli
    Write-Host "Checking tree-sitter-cli..." -NoNewline
    try {
        if (-not (Test-Path -Path "node_modules")) {
            Write-Host " (Installing)..." -NoNewline
            npm install tree-sitter-cli -q | Out-Null
        }
        $result = npx tree-sitter --version -ErrorAction Stop
        Write-Host " ✓" -ForegroundColor Green
    } catch {
        Write-Host " ✗ Missing" -ForegroundColor Red
        $allInstalled = $false
    }
    
    if ($allInstalled) {
        Write-Host "All dependencies are installed!" -ForegroundColor Green
    } else {
        Write-Host "Some dependencies are missing. Please install them and try again." -ForegroundColor Red
        exit 1
    }
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
    
    Write-Host "Tree-sitter tests completed!" -ForegroundColor Green
}

# Function to clone test repository
function Clone-TestRepository {
    Write-Host "Cloning external test repository..."
    
    $repoUrl = "https://gitcode.com/Cangjie/cangjie_test"
    $sourceDir = "cangjie_test"
    $branch = "main"
    
    # Check if source directory already exists
    if (Test-Path -Path $sourceDir -PathType Container) {
        Write-Host "Source directory $sourceDir already exists. Update? (y/n): " -NoNewline
        $response = Read-Host
        if ($response -eq "y" -or $response -eq "Y") {
            Write-Host "Updating existing repository..."
            Set-Location -Path $sourceDir -ErrorAction Stop
            git pull origin $branch
            Set-Location -Path ".." -ErrorAction SilentlyContinue
            Write-Host "Repository updated successfully!" -ForegroundColor Green
        } else {
            Write-Host "Skipping clone operation."
            return
        }
    } else {
        # Clone new repository
        Write-Host "Cloning repository $repoUrl to $sourceDir..."
        git clone --branch $branch $repoUrl $sourceDir
        Write-Host "Repository cloned successfully!" -ForegroundColor Green
    }
}

# Function to copy test files
function Copy-TestFiles {
    Write-Host "Copying test files from external repository..."
    
    $sourceDir = "cangjie_test"
    $targetDirs = @("tests", "tree-sitter-cangjie/tests")
    $count = 50
    
    # Check if source directory exists
    if (-not (Test-Path -Path $sourceDir -PathType Container)) {
        Write-Host "Source directory $sourceDir does not exist. Please run 'clone-tests' first." -ForegroundColor Red
        exit 1
    }
    
    # Get all *.cj files
    $allCjFiles = Get-ChildItem -Path $sourceDir -Filter "*.cj" -Recurse | Select-Object -ExpandProperty FullName
    
    if ($allCjFiles.Count -eq 0) {
        Write-Host "No *.cj files found in source directory." -ForegroundColor Red
        exit 1
    }
    
    # Copy files to each target directory
    foreach ($dir in $targetDirs) {
        # Create target directory if it doesn't exist
        if (-not (Test-Path -Path $dir -PathType Container)) {
            Write-Host "Creating directory $dir..."
            New-Item -Path $dir -ItemType Directory -Force | Out-Null
        }
        
        Write-Host "Copying files to $dir..."
        $randomFiles = $allCjFiles | Get-Random -Count $count
        $success = 0
        $failed = 0
        $counter = 0
        
        foreach ($file in $randomFiles) {
            $counter++
            $newName = "test_$(Get-Date -Format 'yyyyMMdd_HHmmss')_${counter}.cj"
            $destPath = Join-Path $dir $newName
            
            try {
                Copy-Item -Path $file -Destination $destPath -Force
                Write-Host "Copied $file to $destPath"
                $success++
            } catch {
                Write-Host "Failed to copy $file to $destPath" -ForegroundColor Red
                $failed++
            }
        }
        
        Write-Host "Finished copying to ${dir}: ${success} succeeded, ${failed} failed"
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
if ($args.Count -gt 0) {
    $Action = $args[0]
} else {
    $Action = "help"
}

switch ($Action) {
    "help" {
        Show-Help
    }
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
    default {
        Write-Host "Unknown action: $Action" -ForegroundColor Red
        Write-Host "Use 'help' to see available actions." -ForegroundColor Yellow
        Show-Help
    }
}

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Green