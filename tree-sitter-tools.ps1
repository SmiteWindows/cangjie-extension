# Tree-sitter Tools Script for Cangjie Language
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

using namespace System.IO

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
    
    # Define dependencies to check
    $dependencies = @(
        @{ Name = "git"; Command = "git --version" }
        @{ Name = "cargo"; Command = "cargo --version" }
        @{ Name = "node"; Command = "node --version" }
        @{ Name = "npm"; Command = "npm --version" }
    )
    
    # Check each dependency in parallel (PowerShell 7 feature)
    $results = $dependencies | ForEach-Object -Parallel {
        $dep = $_
        try {
            & $dep.Command | Out-Null
            [PSCustomObject]@{ Name = $dep.Name; Status = $true }
        } catch {
            [PSCustomObject]@{ Name = $dep.Name; Status = $false }
        }
    }
    
    # Display results
    foreach ($result in $results) {
        Write-Host "Checking $($result.Name)..." -NoNewline
        if ($result.Status) {
            Write-Host " ✓" -ForegroundColor Green
        } else {
            Write-Host " ✗ Missing" -ForegroundColor Red
            exit 1
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
        exit 1
    }
    
    Write-Host "All dependencies are installed!" -ForegroundColor Green
}

# Function to build Tree-sitter parser
function Build-TreeSitter {
    Write-Host "Building Tree-sitter parser..."
    
    try {
        # Use Push-Location and Pop-Location for better directory management
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        
        # Build Rust bindings with simplified error handling
        Write-Host "Building Rust bindings..."
        cargo build --release
        
        # Build WASI WASM (for server-side)
        Write-Host "Building WASI WASM..."
        cargo build --target wasm32-wasip2 --release
        
        # Build Web WASM (for browser)
        Write-Host "Building Web WASM..."
        cargo build --target wasm32-unknown-unknown --release
        
        # Copy WASI WASM to main directory
        $wasiWasmPath = Join-Path -Path "target" -ChildPath "wasm32-wasip2" -ChildPath "release" -ChildPath "tree_sitter_cangjie.wasm"
        if (Test-Path -Path $wasiWasmPath -PathType Leaf) {
            Copy-Item -Path $wasiWasmPath -Destination ".." -Force
            Write-Host "✓ Copied WASI WASM to main directory" -ForegroundColor Green
        }
        
        # Copy Web WASM to main directory
        $webWasmPath = Join-Path -Path "target" -ChildPath "wasm32-unknown-unknown" -ChildPath "release" -ChildPath "tree_sitter_cangjie.wasm"
        if (Test-Path -Path $webWasmPath -PathType Leaf) {
            Copy-Item -Path $webWasmPath -Destination ".." -ChildPath "tree_sitter_cangjie_web.wasm" -Force
            Write-Host "✓ Copied Web WASM to main directory" -ForegroundColor Green
        }
        
        Write-Host "Tree-sitter parser built successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to build Tree-sitter parser: $_" -ForegroundColor Red
        exit 1
    } finally {
        # Always return to original directory
        Pop-Location -ErrorAction SilentlyContinue
    }
}

# Function to run Tree-sitter tests
function Test-TreeSitter {
    Write-Host "Running Tree-sitter tests..."
    
    try {
        # Use Push-Location and Pop-Location for better directory management
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        
        # Run Rust tests with simplified error handling
        Write-Host "Running Rust tests..."
        cargo test
        
        # Run Tree-sitter CLI tests
        Write-Host "Running Tree-sitter CLI tests..."
        npx tree-sitter test
        
        Write-Host "Tree-sitter tests passed!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to run Tree-sitter tests: $_" -ForegroundColor Red
        exit 1
    } finally {
        # Always return to original directory
        Pop-Location -ErrorAction SilentlyContinue
    }
}

# Function to clone external test repository
function Clone-TestRepository {
    Write-Host "Cloning external test repository..."
    
    try {
        # Check if source directory already exists
        if (Test-Path -Path $SourceDir -PathType Container) {
            Write-Host "Source directory $SourceDir already exists. Update? (y/n): " -NoNewline
            $response = Read-Host
            if ($response -eq "y" -or $response -eq "Y") {
                Write-Host "Updating existing repository..."
                Push-Location -Path $SourceDir -ErrorAction Stop
                git pull origin $Branch
                Write-Host "Repository updated successfully!" -ForegroundColor Green
            } else {
                Write-Host "Skipping clone operation."
                return
            }
        } else {
            # Clone new repository with simplified error handling
            Write-Host "Cloning repository $RepoUrl to $SourceDir..."
            git clone --branch $Branch $RepoUrl $SourceDir
            Write-Host "Repository cloned successfully!" -ForegroundColor Green
        }
    } catch {
        Write-Host "Failed to clone/update repository: $_" -ForegroundColor Red
        exit 1
    } finally {
        # Always return to original directory
        Pop-Location -ErrorAction SilentlyContinue
    }
}

# Function to copy test files from external repository
function Copy-TestFiles {
    Write-Host "Copying test files from external repository..."
    
    try {
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
            $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
            
            # Use sequential processing to ensure unique filenames
            $counter = 1
            $results = @()
            foreach ($file in $randomFiles) {
                $newName = "test_${timestamp}_$($counter).cj"
                $destPath = Join-Path $dir $newName
                
                try {
                    Copy-Item -Path $file -Destination $destPath -Force
                    $results += [PSCustomObject]@{ Success = $true; File = $file; Dest = $destPath }
                } catch {
                    $results += [PSCustomObject]@{ Success = $false; File = $file; Dest = $destPath; Error = $_ }
                }
                
                $counter++
            }
            
            # Calculate results
            $successCount = ($results | Where-Object { $_.Success }).Count
            $failedCount = ($results | Where-Object { -not $_.Success }).Count
            
            # Display results
            $results | ForEach-Object {
                if ($_.Success) {
                    Write-Host "Copied $($_.File) to $($_.Dest)"
                } else {
                    Write-Host "Failed to copy $($_.File) to $($_.Dest) - $($_.Error)" -ForegroundColor Red
                }
            }
            
            Write-Host "Finished copying to ${dir}: ${successCount} succeeded, ${failedCount} failed"
        }
        
        Write-Host "Test files copied successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to copy test files: $_" -ForegroundColor Red
        exit 1
    }
}

# Function to clean generated files
function Clean-GeneratedFiles {
    Write-Host "Cleaning generated files..."
    
    try {
        # Clean WASM files in main directory with simplified error handling
        $wasmFiles = Get-ChildItem -Path "*.wasm" -ErrorAction SilentlyContinue
        if ($wasmFiles.Count -gt 0) {
            Write-Host "Cleaning WASM files in main directory..."
            $wasmFiles | Remove-Item -Force
        }
        
        # Clean generated files in tree-sitter-cangjie directory
        if (Test-Path -Path "tree-sitter-cangjie" -PathType Container) {
            Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
            
            # Clean target directory
            if (Test-Path -Path "target" -PathType Container) {
                Write-Host "Cleaning target directory..."
                Remove-Item -Path "target" -Recurse -Force
            }
            
            # Clean WASM files
            $tsWasmFiles = Get-ChildItem -Path "*.wasm" -ErrorAction SilentlyContinue
            if ($tsWasmFiles.Count -gt 0) {
                Write-Host "Cleaning WASM files..."
                $tsWasmFiles | Remove-Item -Force
            }
        }
        
        Write-Host "Generated files cleaned successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to clean generated files: $_" -ForegroundColor Red
        exit 1
    } finally {
        # Always return to original directory
        Pop-Location -ErrorAction SilentlyContinue
    }
}

# Function to update grammar files
function Update-Grammar {
    Write-Host "Updating grammar files..."
    
    try {
        # Use Push-Location and Pop-Location for better directory management
        Push-Location -Path "tree-sitter-cangjie" -ErrorAction Stop
        
        # Generate grammar files with simplified error handling
        Write-Host "Generating grammar files..."
        npx tree-sitter generate
        
        Write-Host "Grammar files updated successfully!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to update grammar files: $_" -ForegroundColor Red
        exit 1
    } finally {
        # Always return to original directory
        Pop-Location -ErrorAction SilentlyContinue
    }
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