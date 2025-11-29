#Requires -Version 7.0

<#
.SYNOPSIS
    Generates a CHANGELOG.md file from git commit history.

.DESCRIPTION
    This script generates a CHANGELOG.md file based on the git commit history,
    using conventional commit messages to categorize changes.

.PARAMETER OutputFile
    The path to the output CHANGELOG.md file. Defaults to CHANGELOG.md in the current directory.

.PARAMETER Version
    The current version to use for the latest changelog entry.

.EXAMPLE
    .\generate-changelog.ps1 -Version "1.0.0"

.EXAMPLE
    .\generate-changelog.ps1 -OutputFile "docs/CHANGELOG.md" -Version "1.0.0"
#>

param(
    [string]$OutputFile = "CHANGELOG.md",
    [string]$Version
)

# Function to get git tags sorted by version
function Get-SortedTags {
    try {
        $tags = git tag -l 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "No git tags found or git command failed"
            return @()
        }
        
        # Filter and sort tags that match version format
        $versionTags = $tags | Where-Object { $_ -match '^v?\d+\.\d+\.\d+' }
        if ($versionTags.Count -eq 0) {
            return @()
        }
        
        $versionTags | Sort-Object { [System.Version]($_.Replace('v', '')) } -Descending
    } catch {
        Write-Warning "Error getting tags: $($_.Exception.Message)"
        return @()
    }
}

# Function to get commits between two tags
function Get-CommitsBetweenTags {
    param(
        [string]$FromTag,
        [string]$ToTag
    )

    try {
        $commits = @()
        
        if ([string]::IsNullOrEmpty($FromTag)) {
            # Get all commits if no from tag
            $commits = git log --pretty="format:%s" $ToTag 2>$null
        } else {
            $commits = git log --pretty="format:%s" $FromTag..$ToTag 2>$null
        }
        
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Git log command failed for range $FromTag..$ToTag"
            return @()
        }
        
        # Filter out empty commits and ensure array format
        $commits = $commits | Where-Object { -not [string]::IsNullOrEmpty($_) }
        
        if ($commits -is [string]) {
            # Convert single commit to array
            return @($commits)
        }
        
        return $commits
    } catch {
        Write-Warning "Error getting commits: $($_.Exception.Message)"
        return @()
    }
}

# Function to categorize commits
function Get-CategorizedCommits {
    param(
        [array]$Commits
    )

    $categories = @{
        "feat" = @()
        "fix" = @()
        "docs" = @()
        "style" = @()
        "refactor" = @()
        "perf" = @()
        "test" = @()
        "build" = @()
        "ci" = @()
        "chore" = @()
        "revert" = @()
        "other" = @()
    }

    if (-not $Commits -or $Commits.Count -eq 0) {
        return $categories
    }

    foreach ($commit in $Commits) {
        # Skip empty commits
        if ([string]::IsNullOrEmpty($commit)) {
            continue
        }
        
        $matched = $false
        foreach ($category in $categories.Keys) {
            if ($commit -match "^$category(?::|!:)[\s]+") {
                $categories[$category] += $commit
                $matched = $true
                break
            }
        }
        if (-not $matched) {
            $categories["other"] += $commit
        }
    }

    return $categories
}

# Function to format changelog entry
function Format-ChangelogEntry {
    param(
        [string]$Version,
        [string]$Date,
        [hashtable]$CategorizedCommits
    )

    $entry = "## $Version ($Date)\n\n"

    # Define the order of categories to display
    $categoryOrder = @("feat", "fix", "perf", "refactor", "docs", "test", "build", "ci", "style", "chore", "revert", "other")

    $hasContent = $false
    foreach ($category in $categoryOrder) {
        if ($CategorizedCommits[$category].Count -gt 0) {
            $hasContent = $true
            $entry += "### $category\n\n"
            foreach ($commit in $CategorizedCommits[$category]) {
                # Skip empty commits
                if ([string]::IsNullOrEmpty($commit)) {
                    continue
                }
                
                # Remove category prefix and add bullet point
                $formattedCommit = $commit -replace "^$category(?::|!:)[\s]+", "- "
                $entry += "$formattedCommit\n"
            }
            $entry += "\n"
        }
    }

    if (-not $hasContent) {
        $entry += "No changes\n\n"
    }

    return $entry
}

# Main script execution
Write-Host "Generating CHANGELOG.md..."

# Check if we're in a git repository
try {
    git rev-parse --is-inside-work-tree 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Not in a git repository. Please run this script from within a git repository."
        exit 1
    }
} catch {
    Write-Error "Error checking git repository: $($_.Exception.Message)"
    exit 1
}

# Get current date
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Get sorted tags
$sortedTags = Get-SortedTags

# If no version provided, use the latest tag or "Unreleased"
if ([string]::IsNullOrEmpty($Version)) {
    if ($sortedTags.Count -gt 0) {
        $Version = $sortedTags[0]
    } else {
        $Version = "Unreleased"
    }
}

# Generate changelog content
$changelogContent = "# Changelog\n\n"
$changelogContent += "All notable changes to this project will be documented in this file.\n\n"
$changelogContent += "The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),\n"
$changelogContent += "and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).\n\n"

# Get all commits if no tags exist
if ($sortedTags.Count -eq 0) {
    Write-Host "No git tags found, generating changelog for all commits..." -ForegroundColor Yellow
    try {
        $commits = git log --pretty="format:%s" 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "No commits found or git log command failed"
            $commits = @()
        }
        
        # Ensure array format
        if ($commits -is [string]) {
            $commits = @($commits)
        } elseif (-not $commits) {
            $commits = @()
        }
        
        $categorizedCommits = Get-CategorizedCommits -Commits $commits
        $changelogContent += Format-ChangelogEntry -Version $Version -Date $currentDate -CategorizedCommits $categorizedCommits
    } catch {
        Write-Warning "Error processing commits: $($_.Exception.Message)"
        $changelogContent += Format-ChangelogEntry -Version $Version -Date $currentDate -CategorizedCommits @{}
    }
} else {
    # Process each tag
    Write-Host "Found $($sortedTags.Count) git tags, processing..." -ForegroundColor Yellow
    for ($i = 0; $i -lt $sortedTags.Count; $i++) {
        $tag = $sortedTags[$i]
        $fromTag = if ($i -lt $sortedTags.Count - 1) { $sortedTags[$i + 1] } else { "" }
        
        Write-Host "  Processing tag $tag..." -ForegroundColor DarkYellow
        
        $commits = Get-CommitsBetweenTags -FromTag $fromTag -ToTag $tag
        $categorizedCommits = Get-CategorizedCommits -Commits $commits
        
        # Get tag date
        try {
            $tagDate = git log -1 --format="%ai" $tag 2>$null | ForEach-Object { Get-Date $_ -Format "yyyy-MM-dd" }
            if (-not $tagDate) {
                $tagDate = $currentDate
                Write-Warning "Could not get date for tag ${tag}, using current date"
            }
        } catch {
            $tagDate = $currentDate
            Write-Warning "Error getting date for tag ${tag}: $($_.Exception.Message), using current date"
        }
        
        $changelogContent += Format-ChangelogEntry -Version $tag -Date $tagDate -CategorizedCommits $categorizedCommits
    }
}

# Write to file
try {
    Set-Content -Path $OutputFile -Value $changelogContent -Encoding UTF8
    Write-Host "✓ CHANGELOG.md generated successfully at $OutputFile" -ForegroundColor Green
} catch {
    Write-Error "Error writing to file ${OutputFile}: $($_.Exception.Message)"
    exit 1
}
