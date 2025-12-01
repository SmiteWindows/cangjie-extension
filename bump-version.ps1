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

<#
.SYNOPSIS
    Bumps the version number in project files and creates a git tag.

.DESCRIPTION
    This script updates the version number in project files (package.json, extension.toml, etc.)
    and creates a git tag for the new version. It supports semantic versioning (major, minor, patch).

.PARAMETER Type
    The type of version bump to perform: major, minor, or patch. Defaults to patch.

.PARAMETER Version
    The exact version number to use instead of bumping. If specified, the Type parameter is ignored.

.PARAMETER Preview
    If specified, the script will show what changes would be made without actually making them.

.PARAMETER Files
    Additional files to update with the new version number.

.EXAMPLE
    .\bump-version.ps1 -Type minor

.EXAMPLE
    .\bump-version.ps1 -Version "1.2.3"

.EXAMPLE
    .\bump-version.ps1 -Type patch -Preview
#>

param(
    [ValidateSet("major", "minor", "patch")]
    [string]$Type = "patch",
    [string]$Version,
    [switch]$Preview,
    [array]$Files = @()
)

# Function to get the current version from package.json
function Get-CurrentVersion {
    if (Test-Path -Path "package.json") {
        $packageJson = Get-Content -Path "package.json" -Raw | ConvertFrom-Json
        return $packageJson.version
    } elseif (Test-Path -Path "extension.toml") {
        $extensionToml = Get-Content -Path "extension.toml" -Raw
        if ($extensionToml -match 'version\s*=\s*"([^"]+)"') {
            return $Matches[1]
        }
    }
    throw "Could not determine current version. Please check if package.json or extension.toml exists."
}

# Function to bump the version
function Bump-Version {
    param(
        [string]$CurrentVersion,
        [string]$Type
    )

    $versionParts = $CurrentVersion -split "\."
    if ($versionParts.Count -ne 3) {
        throw "Invalid version format. Expected major.minor.patch."
    }

    [int]$major = $versionParts[0]
    [int]$minor = $versionParts[1]
    [int]$patch = $versionParts[2]

    switch ($Type) {
        "major" {
            $major++
            $minor = 0
            $patch = 0
        }
        "minor" {
            $minor++
            $patch = 0
        }
        "patch" {
            $patch++
        }
    }

    return "$major.$minor.$patch"
}

# Function to update version in package.json
function Update-PackageJson {
    param(
        [string]$NewVersion,
        [switch]$Preview
    )

    if (Test-Path -Path "package.json") {
        $packageJson = Get-Content -Path "package.json" -Raw | ConvertFrom-Json
        $oldVersion = $packageJson.version
        $packageJson.version = $NewVersion
        
        if ($Preview) {
            Write-Host "Would update package.json: $oldVersion -> $NewVersion" -ForegroundColor Yellow
        } else {
            $packageJson | ConvertTo-Json -Depth 100 | Set-Content -Path "package.json"
            Write-Host "✓ Updated package.json: $oldVersion -> $NewVersion" -ForegroundColor Green
        }
    }
}

# Function to update version in extension.toml
function Update-ExtensionToml {
    param(
        [string]$NewVersion,
        [switch]$Preview
    )

    if (Test-Path -Path "extension.toml") {
        $extensionToml = Get-Content -Path "extension.toml" -Raw
        if ($extensionToml -match 'version\s*=\s*"([^"]+)"') {
            $oldVersion = $Matches[1]
            $pattern = 'version\s*=\s*"' + [regex]::Escape($oldVersion) + '"'
            $replacement = 'version = "' + $NewVersion + '"'
            $newContent = $extensionToml -replace $pattern, $replacement
            
            if ($Preview) {
                Write-Host "Would update extension.toml: $oldVersion -> $NewVersion" -ForegroundColor Yellow
            } else {
                Set-Content -Path "extension.toml" -Value $newContent
                Write-Host "✓ Updated extension.toml: $oldVersion -> $NewVersion" -ForegroundColor Green
            }
        }
    }
}

# Function to update version in additional files
function Update-AdditionalFiles {
    param(
        [string]$CurrentVersion,
        [string]$NewVersion,
        [array]$Files,
        [switch]$Preview
    )

    foreach ($file in $Files) {
        if (Test-Path -Path $file) {
            $content = Get-Content -Path $file -Raw
            $oldContent = $content
            $content = $content -replace $CurrentVersion, $NewVersion
            
            if ($content -ne $oldContent) {
                if ($Preview) {
                    Write-Host "Would update ${file}: $CurrentVersion -> $NewVersion" -ForegroundColor Yellow
                } else {
                    Set-Content -Path $file -Value $content
                    Write-Host "✓ Updated ${file}: $CurrentVersion -> $NewVersion" -ForegroundColor Green
                }
            }
        } else {
            Write-Host "✗ File not found: $file" -ForegroundColor Red
        }
    }
}

# Function to create git tag
function Create-GitTag {
    param(
        [string]$NewVersion,
        [switch]$Preview
    )

    if ($Preview) {
        Write-Host "Would create git tag: v$NewVersion" -ForegroundColor Yellow
    } else {
        git tag -a "v$NewVersion" -m "Version $NewVersion"
        Write-Host "✓ Created git tag: v$NewVersion" -ForegroundColor Green
    }
}

# Main script execution
Write-Host "Bumping version..."

# Get current version
$currentVersion = Get-CurrentVersion
Write-Host "Current version: $currentVersion" -ForegroundColor Cyan

# Determine new version
if ([string]::IsNullOrEmpty($Version)) {
    $newVersion = Bump-Version -CurrentVersion $currentVersion -Type $Type
} else {
    $newVersion = $Version
}

Write-Host "New version: $newVersion" -ForegroundColor Cyan
Write-Host "=" * 40

# Update files
Update-PackageJson -NewVersion $newVersion -Preview:$Preview
Update-ExtensionToml -NewVersion $newVersion -Preview:$Preview
Update-AdditionalFiles -CurrentVersion $currentVersion -NewVersion $newVersion -Files $Files -Preview:$Preview

# Create git tag
Create-GitTag -NewVersion $newVersion -Preview:$Preview

Write-Host "=" * 40
if ($Preview) {
    Write-Host "Preview mode: No changes were actually made." -ForegroundColor Yellow
} else {
    Write-Host "Version bump completed successfully!" -ForegroundColor Green
    Write-Host "To push the new tag, run: git push origin v$newVersion" -ForegroundColor Cyan
}

