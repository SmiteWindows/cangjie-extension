# PowerShell 7 Configuration Guide

This guide explains how to configure the environment to always use PowerShell 7 for executing scripts.

## Current Configuration

- **PowerShell 7 Version**: 7.5.4
- **Default Shell**: powershell7+ (for all terminals)
- **Command**: `pwsh` (alias for PowerShell 7)

## Usage

### Option 1: Use pwsh Command Directly

```powershell
pwsh -ExecutionPolicy Bypass -File .\tree-sitter-tools.ps1 -Action help
```

### Option 2: Use the Batch Wrapper

We've created a batch file `run-ps-script.bat` that ensures PowerShell 7 is used:

```powershell
.
un-ps-script.bat .\tree-sitter-tools.ps1 -Action help
```

### Option 3: Set Up PowerShell Profile

Add this to your PowerShell profile (`$PROFILE`):

```powershell
# Alias powershell to pwsh to ensure PowerShell 7 is used
alias powershell='pwsh'
```

## Files

- `run-ps-script.bat`: Batch wrapper to ensure PowerShell 7 is used
- `profile.ps1`: Sample PowerShell profile configuration
- `update-ps1-scripts.ps1`: Script to update all PS1 files to require PowerShell 7

## Testing

To verify PowerShell 7 is being used:

```powershell
$PSVersionTable
```

Expected output:
```
Name                           Value
----                           -----PSVersion                      7.5.4
PSEdition                      Core
GitCommitId                    7.5.4
```

## Troubleshooting

### Error: "无法运行脚本，因为该脚本包含用于 Windows PowerShell 7.0 的 '#requires' 语句"

This means you're trying to run a PowerShell 7 script with PowerShell 5.1. Use `pwsh` instead of `powershell`.

### Error: "pwsh: The term 'pwsh' is not recognized"

PowerShell 7 is not installed. Please install PowerShell 7 from [Microsoft's website](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows).

## Best Practices

1. Always use `pwsh` instead of `powershell` to ensure PowerShell 7 is used
2. Add `#Requires -Version 7.0` to the top of all PowerShell scripts
3. Use the `run-ps-script.bat` wrapper for consistent execution
4. Set up the PowerShell profile for automatic alias configuration

## Scripts

All PS1 scripts in this repository have been updated to require PowerShell 7:

- [x] cangjie-tree-sitter.ps1
- [x] copy_random_tests.ps1
- [x] copy_tests_simple.ps1
- [x] simple-tree-sitter.ps1
- [x] test-cangjie.ps1
- [x] test-deps.ps1
- [x] test-script.ps1
- [x] tree-sitter-helper.ps1
- [x] tree-sitter-simple.ps1
- [x] tree-sitter-tools-final.ps1
- [x] tree-sitter-tools-simple.ps1
- [x] tree-sitter-tools.ps1

Each script now includes `#Requires -Version 7.0` at the top, ensuring it can only be executed with PowerShell 7.
