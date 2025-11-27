# Simple Tree-sitter Helper Script
# This script provides basic functionality for managing the Cangjie Tree-sitter parser

Write-Host "Tree-sitter Helper Script for Cangjie Language"
Write-Host "==============================================="
Write-Host ""

# Display menu
Write-Host "Available Actions:"
Write-Host "1. Show Help"
Write-Host "2. Build Tree-sitter Parser"
Write-Host "3. Run Tests"
Write-Host "4. Copy Test Files"
Write-Host "5. Clean Generated Files"
Write-Host "6. Update Grammar"
Write-Host "7. Check Dependencies"
Write-Host "8. Clone Test Repository"
Write-Host "0. Exit"
Write-Host ""

# Get user input
$choice = Read-Host "Enter your choice (0-8)"
Write-Host ""

# Execute selected action
switch ($choice) {
    "1" {
        Write-Host "Help Information:"
        Write-Host "This script helps manage the Cangjie Tree-sitter parser."
        Write-Host "Select an option from the menu to perform an action."
    }
    "2" {
        Write-Host "Building Tree-sitter Parser..."
        Set-Location -Path "tree-sitter-cangjie"
        cargo build --release
        npx tree-sitter build --wasm
        Copy-Item -Path "*.wasm" -Destination ".." -Force
        Set-Location -Path ".."
        Write-Host "Build completed!"
    }
    "3" {
        Write-Host "Running Tests..."
        Set-Location -Path "tree-sitter-cangjie"
        cargo test
        npx tree-sitter test
        Set-Location -Path ".."
        Write-Host "Tests completed!"
    }
    "4" {
        Write-Host "Copying Test Files..."
        $sourceDir = "cangjie_test"
        $targetDirs = @("tests", "tree-sitter-cangjie/tests")
        
        foreach ($dir in $targetDirs) {
            if (-not (Test-Path -Path $dir)) {
                New-Item -Path $dir -ItemType Directory -Force | Out-Null
            }
            
            $files = Get-ChildItem -Path $sourceDir -Filter "*.cj" -Recurse | Get-Random -Count 50
            $counter = 0
            
            foreach ($file in $files) {
                $counter++
                $newName = "test_$(Get-Date -Format 'yyyyMMdd_HHmmss')_${counter}.cj"
                $destPath = Join-Path $dir $newName
                Copy-Item -Path $file.FullName -Destination $destPath -Force
            }
            
            Write-Host "Copied 50 files to $dir"
        }
        
        Write-Host "Test files copied!"
    }
    "5" {
        Write-Host "Cleaning Generated Files..."
        
        # Clean WASM files
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
        
        Write-Host "Files cleaned!"
    }
    "6" {
        Write-Host "Updating Grammar..."
        Set-Location -Path "tree-sitter-cangjie"
        npx tree-sitter generate
        Set-Location -Path ".."
        Write-Host "Grammar updated!"
    }
    "7" {
        Write-Host "Checking Dependencies..."
        
        $deps = @("git", "cargo", "node", "npm")
        
        foreach ($dep in $deps) {
            Write-Host "Checking $dep..." -NoNewline
            try {
                Invoke-Expression "$dep --version" | Out-Null
                Write-Host " ✓" -ForegroundColor Green
            } catch {
                Write-Host " ✗" -ForegroundColor Red
            }
        }
        
        # Check tree-sitter-cli
        Write-Host "Checking tree-sitter-cli..." -NoNewline
        try {
            if (-not (Test-Path -Path "node_modules")) {
                Write-Host " (Installing)..." -NoNewline
                npm install tree-sitter-cli -q | Out-Null
            }
            npx tree-sitter --version | Out-Null
            Write-Host " ✓" -ForegroundColor Green
        } catch {
            Write-Host " ✗" -ForegroundColor Red
        }
        
        Write-Host "Dependencies checked!"
    }
    "8" {
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
        
        Write-Host "Repository cloned/updated!"
    }
    "0" {
        Write-Host "Exiting script..."
        exit 0
    }
    default {
        Write-Host "Invalid choice. Please try again." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Green