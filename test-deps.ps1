# Test script for dependency checking

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
    
    if ($missingDeps.Count -gt 0) {
        Write-Host "`nThe following dependencies are missing: $($missingDeps -join ', ')" -ForegroundColor Red
        Write-Host "Please install the missing dependencies and run the script again." -ForegroundColor Red
        exit 1
    } else {
        Write-Host "`n✓ All dependencies are installed!" -ForegroundColor Green
    }
}

Check-Dependencies
Write-Host "`nScript completed!"