#!/usr/bin/env pwsh

# Test script for Cangjie Tree-sitter grammar
# This script automates the testing process for the Cangjie language grammar

Write-Host "=== Cangjie Tree-sitter Grammar Test Suite ==="
Write-Host ""

# Change to the tree-sitter-cangjie directory
Set-Location -Path "$PSScriptRoot\tree-sitter-cangjie"

# Step 1: Generate the parser
Write-Host "1. Generating parser..."
& tree-sitter generate
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Parser generation failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Parser generation successful!" -ForegroundColor Green
Write-Host ""

# Step 2: Run the test suite
Write-Host "2. Running test suite..."
& tree-sitter test
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Test suite failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Test suite passed!" -ForegroundColor Green
Write-Host ""

# Step 3: Parse all test files individually
Write-Host "3. Parsing all test files..."
$testFiles = Get-ChildItem -Path "tests\*.cj" -Recurse
$failedFiles = @()

foreach ($file in $testFiles) {
    Write-Host "   Parsing $($file.Name)..." -NoNewline
    & tree-sitter parse $file.FullName > $null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host " ❌" -ForegroundColor Red
        $failedFiles += $file.Name
    } else {
        Write-Host " ✅" -ForegroundColor Green
    }
}

if ($failedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "❌ Failed to parse the following files:" -ForegroundColor Red
    foreach ($file in $failedFiles) {
        Write-Host "   - $file" -ForegroundColor Red
    }
    exit 1
}

Write-Host ""
Write-Host "✅ All test files parsed successfully!" -ForegroundColor Green
Write-Host ""

# Step 4: Check for diagnostics
Write-Host "4. Checking for diagnostics..."
$diagnostics = & Get-Process | Where-Object {$_.ProcessName -eq "Code"} | Select-Object -First 1
if ($diagnostics) {
    # This is a placeholder - in a real VS Code environment, we'd use the VS Code API to get diagnostics
    Write-Host "⚠️  Diagnostics check skipped (requires VS Code API)" -ForegroundColor Yellow
} else {
    Write-Host "⚠️  VS Code not found, diagnostics check skipped" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Test Summary ===" -ForegroundColor Cyan
Write-Host "✅ Parser generation: Successful" -ForegroundColor Green
Write-Host "✅ Test suite: Passed" -ForegroundColor Green
Write-Host "✅ All test files parsed successfully" -ForegroundColor Green
Write-Host ""
Write-Host "🎉 All tests passed! The Cangjie grammar is working correctly." -ForegroundColor Green
Write-Host ""

# Return to original directory
Set-Location -Path $PSScriptRoot
