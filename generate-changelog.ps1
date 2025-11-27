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
    git tag -l | Sort-Object { [System.Version]$_ } -Descending
}

# Function to get commits between two tags
function Get-CommitsBetweenTags {
    param(
        [string]$FromTag,
        [string]$ToTag
    )

    if ([string]::IsNullOrEmpty($FromTag)) {
        # Get all commits if no from tag
        git log --pretty="format:%s" $ToTag
    } else {
        git log --pretty="format:%s" $FromTag..$ToTag
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

    foreach ($commit in $Commits) {
        $matched = $false
        foreach ($category in $categories.Keys) {
            if ($commit -match "^$category(?::|!:)\s+") {
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

    foreach ($category in $categoryOrder) {
        if ($CategorizedCommits[$category].Count -gt 0) {
            $entry += "### $category\n\n"
            foreach ($commit in $CategorizedCommits[$category]) {
                # Remove category prefix and add bullet point
                $formattedCommit = $commit -replace "^$category(?::|!:)\s+", "- "
                $entry += "$formattedCommit\n"
            }
            $entry += "\n"
        }
    }

    return $entry
}

# Main script execution
Write-Host "Generating CHANGELOG.md..."

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
    $commits = git log --pretty="format:%s"
    $categorizedCommits = Get-CategorizedCommits -Commits $commits
    $changelogContent += Format-ChangelogEntry -Version $Version -Date $currentDate -CategorizedCommits $categorizedCommits
} else {
    # Process each tag
    for ($i = 0; $i -lt $sortedTags.Count; $i++) {
        $tag = $sortedTags[$i]
        $fromTag = if ($i -lt $sortedTags.Count - 1) { $sortedTags[$i + 1] } else { "" }
        
        $commits = Get-CommitsBetweenTags -FromTag $fromTag -ToTag $tag
        $categorizedCommits = Get-CategorizedCommits -Commits $commits
        
        # Get tag date
        $tagDate = git log -1 --format="%ai" $tag | ForEach-Object { Get-Date $_ -Format "yyyy-MM-dd" }
        
        $changelogContent += Format-ChangelogEntry -Version $tag -Date $tagDate -CategorizedCommits $categorizedCommits
    }
}

# Write to file
Set-Content -Path $OutputFile -Value $changelogContent

Write-Host "✓ CHANGELOG.md generated successfully at $OutputFile" -ForegroundColor Green
