<#
.SYNOPSIS
    Updates all PowerShell scripts with best practices for PowerShell 7+

.DESCRIPTION
    This script automates the process of updating all PowerShell scripts in the project
    to follow PowerShell 7+ best practices, including:
    - Adding #Requires -Version 7.0 declaration
    - Setting strict mode and error preferences
    - Ensuring proper parameter block position
    - Ensuring proper using namespace position
    - Consistent encoding and formatting
    - Correct syntax and structure

.PARAMETER DryRun
    If specified, performs a dry run without making changes to files.
    Shows what changes would be made but doesn't modify any files.

.PARAMETER Help
    If specified, displays this help information and exits.

.EXAMPLE
    .\update-ps1-best-practices.ps1
    Updates all scripts with PowerShell 7+ best practices.

.EXAMPLE
    .\update-ps1-best-practices.ps1 -DryRun
    Performs a dry run without making changes to files.

.EXAMPLE
    .\update-ps1-best-practices.ps1 -Help
    Displays this help information.

.NOTES
    This script requires PowerShell 7 or later.
    It processes all PS1 files in the project, excluding node_modules directories.
    It ensures consistent formatting and structure across all scripts.
    The script maintains existing content while adding/updating best practices declarations.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

param(
    [switch]$DryRun,
    [switch]$Help
)

function Show-Help {
    Get-Help -Name $PSCommandPath -Full
    exit 0
}

if ($Help) {
    Show-Help
}

# Get all PS1 files excluding node_modules
$ps1Files = Get-ChildItem -Path . -Filter "*.ps1" -Recurse | Where-Object { $_.FullName -notlike "*node_modules*" }

Write-Host "Found $($ps1Files.Count) PowerShell scripts to update." -ForegroundColor Green
Write-Host "=" * 80

foreach ($file in $ps1Files) {
    Write-Host "Processing: $($file.FullName)" -ForegroundColor Cyan
    
    try {
        # Read file content with UTF8 encoding
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Skip already updated files (check for #Requires -Version 7.0)
        if ($content -match '^\s*#Requires\s+-Version\s+7\.0' -and $content -match '^\s*Set-StrictMode\s+-Version\s+Latest') {
            Write-Host "  ✓ Already updated with best practices" -ForegroundColor Green
            continue
        }
        
        # Extract help comments if present
        $helpContent = ""
        $nonHelpContent = $content
        
        # Check for help comments (starting with <# and ending with #>)
        if ($content -match '^(\s*<#[\s\S]*?^\s*#>)([\s\S]*)$') {
            $helpContent = $Matches[1]
            $nonHelpContent = $Matches[2]
        }
        
        # Extract using namespace statements if present
        $usingStatements = @()
        $usingPattern = '(^\s*using\s+namespace\s+[\w.]+\s*\r?\n)'
        while ($nonHelpContent -match $usingPattern) {
            $usingStatements += $Matches[1]
            $nonHelpContent = $nonHelpContent -replace $usingPattern, ''
        }
        
        # Extract param block if present
        $paramBlock = ""
        $paramPattern = '(^\s*param\s*\([\s\S]*?^\s*\)\s*\r?\n)'
        if ($nonHelpContent -match $paramPattern) {
            $paramBlock = $Matches[1]
            $nonHelpContent = $nonHelpContent -replace $paramPattern, ''
        }
        
        # Extract ensure PowerShell 7 code if present
        $pwsh7Check = ""
        $pwsh7Pattern = '(^\s*#\s*Ensure\s+PowerShell\s+7\s+environment[\s\S]*?^\s*}$\s*\r?\n)'
        if ($nonHelpContent -match $pwsh7Pattern) {
            $pwsh7Check = $Matches[1]
            $nonHelpContent = $nonHelpContent -replace $pwsh7Pattern, ''
        }
        
        # Create updated content structure
        $updatedContent = ""
        
        # Add help content if present
        if ($helpContent) {
            $updatedContent += $helpContent + "`n`n"
        }
        
        # Add best practices declarations
        $updatedContent += "#Requires -Version 7.0`nSet-StrictMode -Version Latest`n`$ErrorActionPreference = `"Stop`"`n`n"
        
        # Add using namespace statements if present
        if ($usingStatements.Count -gt 0) {
            $updatedContent += $usingStatements -join "`n" + "`n"
        }
        
        # Add param block if present
        if ($paramBlock) {
            $updatedContent += $paramBlock
        }
        
        # Add PowerShell 7 check if present
        if ($pwsh7Check) {
            $updatedContent += $pwsh7Check
        }
        
        # Add remaining content
        $updatedContent += $nonHelpContent.TrimStart()
        
        # Remove duplicate empty lines
        $updatedContent = $updatedContent -replace "`n{3,}", "`n`n"
        
        # Compare with original content
        if ($updatedContent -eq $content) {
            Write-Host "  ✓ No changes needed" -ForegroundColor Green
        } else {
            if (-not $DryRun) {
                # Save updated content with UTF8 encoding
                Set-Content -Path $file.FullName -Value $updatedContent -Encoding UTF8
                Write-Host "  ✅ Updated with best practices" -ForegroundColor Green
            } else {
                Write-Host "  ⚠️  Would update with best practices (Dry run)" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "  ❌ Error processing file: $($_.Exception.Message)" -ForegroundColor Red
        continue
    }
}

Write-Host "=" * 80
Write-Host "Processing complete!" -ForegroundColor Green
if (-not $DryRun) {
    Write-Host "Updated $($ps1Files.Count) scripts with PowerShell 7+ best practices." -ForegroundColor Green
} else {
    Write-Host "Dry run completed. No changes were made." -ForegroundColor Yellow
}

