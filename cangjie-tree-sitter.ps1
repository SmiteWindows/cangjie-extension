# Cangjie Tree-sitter Management Script
# Version: 1.0
# A simple script to manage the Cangjie language Tree-sitter parser

Write-Host "Cangjie Tree-sitter Manager"
Write-Host "============================="
Write-Host ""

# Main menu function
function Show-Menu {
    Write-Host "Available Actions:"
    Write-Host "1. Build Parser       - Build Tree-sitter parser"
    Write-Host "2. Run Tests         - Run Tree-sitter tests"
    Write-Host "3. Copy Test Files   - Copy test files from external repo"
    Write-Host "4. Clean Files       - Clean generated files"
    Write-Host "5. Update Grammar    - Update grammar files"
    Write-Host "6. Check Dependencies - Check required dependencies"
    Write-Host "7. Clone Test Repo   - Clone external test repository"
    Write-Host "0. Exit              - Exit the script"
    Write-Host ""
}

# Function to check if a command exists
function Test-Command($cmd) {
    $result = Get-Command $cmd -ErrorAction SilentlyContinue
    return $result -ne $null
}

# Build parser function
function Build-Parser {
    Write-Host "Building Tree-sitter Parser..."
    Set-Location -Path "tree-sitter-cangjie"
    cargo build --release
    npx tree-sitter build --wasm
    Copy-Item -Path "*.wasm" -Destination ".." -Force
    Set-Location -Path ".."
    Write-Host "Build completed successfully!" -ForegroundColor Green
}

# Run tests function
function Run-Tests {
    Write-Host "Running Tests..."
    Set-Location -Path "tree-sitter-cangjie"
    cargo test
    npx tree-sitter test
    Set-Location -Path ".."
    Write-Host "Tests completed!" -ForegroundColor Green
}

# Copy test files function
function Copy-TestFiles {
    Write-Host "Copying Test Files..."
    $sourceDir = "cangjie_test"
    $targetDirs = @("tests", "tree-sitter-cangjie/tests")
    $count = 50
    
    # Verify source directory exists
    if (-not (Test-Path -Path $sourceDir)) {
        Write-Host "Error: Source directory '$sourceDir' not found!" -ForegroundColor Red
        Write-Host "Please run 'Clone Test Repo' first." -ForegroundColor Yellow
        return
    }
    
    # Get all cj files
    $allFiles = Get-ChildItem -Path $sourceDir -Filter "*.cj" -Recurse
    if ($allFiles.Count -eq 0) {
        Write-Host "Error: No .cj files found in '$sourceDir'!" -ForegroundColor Red
        return
    }
    
    # Ensure we don't try to copy more files than available
    if ($allFiles.Count -lt $count) {
        $count = $allFiles.Count
        Write-Host "Note: Only $count files available, copying all." -ForegroundColor Yellow
    }
    
    # Copy files to each target directory
    foreach ($dir in $targetDirs) {
        # Create directory if it doesn't exist
        if (-not (Test-Path -Path $dir)) {
            Write-Host "Creating directory '$dir'..."
            New-Item -Path $dir -ItemType Directory -Force | Out-Null
        }
        
        # Select random files
        $randomFiles = $allFiles | Get-Random -Count $count
        $success = 0
        $failed = 0
        
        # Copy files
        foreach ($file in $randomFiles) {
            $newName = "test_$(Get-Date -Format 'yyyyMMdd_HHmmss')_$success.cj"
            $destPath = Join-Path $dir $newName
            
            Copy-Item -Path $file.FullName -Destination $destPath -Force
            if ($?) {
                $success++
            } else {
                $failed++
            }
        }
        
        Write-Host "Copied $success files to '$dir' (Failed: $failed)" -ForegroundColor Green
    }
    
    Write-Host "Test files copied successfully!" -ForegroundColor Green
}

# Clean files function
function Clean-Files {
    Write-Host "Cleaning Generated Files..."
    
    # Clean WASM files in root directory
    if (Test-Path -Path "*.wasm") {
        Write-Host "Removing WASM files from root directory..."
        Remove-Item -Path "*.wasm" -Force
    }
    
    # Clean tree-sitter-cangjie directory
    if (Test-Path -Path "tree-sitter-cangjie") {
        Set-Location -Path "tree-sitter-cangjie"
        
        # Clean target directory
        if (Test-Path -Path "target") {
            Write-Host "Removing target directory..."
            Remove-Item -Path "target" -Recurse -Force
        }
        
        # Clean WASM files
        if (Test-Path -Path "*.wasm") {
            Write-Host "Removing WASM files..."
            Remove-Item -Path "*.wasm" -Force
        }
        
        Set-Location -Path ".."
    }
    
    Write-Host "Cleanup completed!" -ForegroundColor Green
}

# Update grammar function
function Update-Grammar {
    Write-Host "Updating Grammar..."
    Set-Location -Path "tree-sitter-cangjie"
    npx tree-sitter generate
    Set-Location -Path ".."
    Write-Host "Grammar updated successfully!" -ForegroundColor Green
}

# Check dependencies function
function Check-Dependencies {
    Write-Host "Checking Dependencies..."
    Write-Host "========================"
    
    $dependencies = @("git", "cargo", "node", "npm")
    $allInstalled = $true
    
    # Check each dependency
    foreach ($dep in $dependencies) {
        Write-Host "${dep}: " -NoNewline
        if (Test-Command $dep) {
            Write-Host "✓ Installed" -ForegroundColor Green
        } else {
            Write-Host "✗ Missing" -ForegroundColor Red
            $allInstalled = $false
        }
    }
    
    # Check tree-sitter-cli separately
    Write-Host "tree-sitter-cli: " -NoNewline
    
    # Install tree-sitter-cli if not present
    if (-not (Test-Path -Path "node_modules")) {
        Write-Host "Installing... " -NoNewline
        npm install tree-sitter-cli -q | Out-Null
    }
    
    # Test if tree-sitter-cli works
    npx tree-sitter --version | Out-Null
    if ($?) {
        Write-Host "✓ Installed" -ForegroundColor Green
    } else {
        Write-Host "✗ Missing" -ForegroundColor Red
        $allInstalled = $false
    }
    
    Write-Host "========================"
    if ($allInstalled) {
        Write-Host "All dependencies are installed!" -ForegroundColor Green
    } else {
        Write-Host "Some dependencies are missing!" -ForegroundColor Red
        Write-Host "Please install the missing dependencies and try again." -ForegroundColor Yellow
    }
}

# Clone test repository function
function Clone-TestRepo {
    Write-Host "Cloning Test Repository..."
    $repoUrl = "https://gitcode.com/Cangjie/cangjie_test"
    $targetDir = "cangjie_test"
    
    if (Test-Path -Path $targetDir) {
        Write-Host "Directory '$targetDir' already exists." -ForegroundColor Yellow
        Write-Host "Updating existing repository..."
        Set-Location -Path $targetDir
        git pull origin main
        Set-Location -Path ".."
    } else {
        Write-Host "Cloning repository from $repoUrl..."
        git clone --branch main $repoUrl $targetDir
    }
    
    Write-Host "Repository cloned/updated successfully!" -ForegroundColor Green
}

# Main script loop
Show-Menu
$choice = Read-Host "Enter your choice (0-7)"

switch ($choice) {
    "1" { Build-Parser }
    "2" { Run-Tests }
    "3" { Copy-TestFiles }
    "4" { Clean-Files }
    "5" { Update-Grammar }
    "6" { Check-Dependencies }
    "7" { Clone-TestRepo }
    "0" { exit 0 }
    default {
        Write-Host "Error: Invalid choice! Please enter a number between 0 and 7." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Green