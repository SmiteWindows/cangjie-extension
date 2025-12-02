# Cangjie Extension Script Launchers

This project provides three script launchers for managing and running PowerShell scripts in the Cangjie Extension project:

1. **Command-line Script Launcher** (`script-launcher.ps1`) - A text-based launcher with menu navigation
2. **Windows Forms GUI Launcher** (`gui-script-launcher.ps1`) - A graphical launcher with modern Windows Forms UI
3. **WPF GUI Launcher** (`wpf-script-launcher.ps1`) - A modern graphical launcher with WPF UI

## Launch Points in Trae IDE

### Using Launch Configurations

The project includes VS Code launch configurations that can be used in Trae IDE:

1. Open the project in Trae IDE
2. Press `Ctrl+Shift+D` to open the Run and Debug panel
3. Select one of the launch configurations from the dropdown menu:
   - Command-line Script Launcher
   - Windows Forms GUI Launcher
   - WPF GUI Launcher
4. Click the green play button to start the launcher

### Using Tasks

The project also includes VS Code tasks for running the launchers:

1. Open the project in Trae IDE
2. Press `Ctrl+Shift+P` to open the command palette
3. Type "Tasks: Run Task" and press Enter
4. Select one of the tasks from the list:
   - Run Command-line Script Launcher
   - Run Windows Forms GUI Launcher
   - Run WPF GUI Launcher
   - Run All Script Launchers (runs all three in parallel)

## Launch Configuration Details

### Command-line Script Launcher
- **File**: `script-launcher.ps1`
- **Type**: Command-line interface with menu navigation
- **Features**: Settings menu, script categories, detailed script information
- **Output**: Integrated terminal

### Windows Forms GUI Launcher
- **File**: `gui-script-launcher.ps1`
- **Type**: Graphical user interface using Windows Forms
- **Features**: Modern design, tree view navigation, detailed script information
- **Output**: Integrated terminal with GUI window

### WPF GUI Launcher
- **File**: `wpf-script-launcher.ps1`
- **Type**: Modern graphical user interface using WPF
- **Features**: Fluent design, tree view navigation, detailed script information
- **Output**: Integrated terminal with GUI window

## Settings

Each launcher has its own settings file stored in JSON format:

- `script-launcher-settings.json` - Settings for command-line launcher
- `gui-script-launcher-settings.json` - Settings for Windows Forms launcher
- `wpf-script-launcher-settings.json` - Settings for WPF launcher

Settings include:
- Execution policy
- Verbose/debug modes
- Error handling preferences
- Working directory
- UI layout preferences
- Script output visibility
- Auto-save options

## Adding New Scripts

To add new scripts to the launchers, edit the `$ScriptCategories` hashtable in each launcher file. Each script should be added to an appropriate category with:

```powershell
@{ Name = "ScriptName.ps1"; Path = "path/to/script.ps1"; Description = "Script description" }
```

## Requirements

- PowerShell 7 or later
- Windows 10 or later for GUI launchers
- .NET Framework 4.7.2 or later for Windows Forms launcher
- .NET Framework 4.7.2 or later for WPF launcher

## Troubleshooting

### Launch Configurations Not Showing

If the launch configurations don't appear in the Run and Debug panel:

1. Ensure the project is opened as a workspace in Trae IDE
2. Check that the `.vscode/launch.json` file exists and is properly formatted
3. Reload the window by pressing `Ctrl+Shift+P` and selecting "Developer: Reload Window"

### GUI Launchers Not Working

If the GUI launchers don't start:

1. Ensure you're running PowerShell 7 or later
2. Ensure you're on Windows 10 or later
3. Check that .NET Framework is installed
4. Run the launcher directly from the terminal to see error messages:
   ```
   pwsh -File gui-script-launcher.ps1
   ```

## Contributing

Contributions to the script launchers are welcome! Please follow these guidelines:

1. Keep changes compatible with PowerShell 7
2. Maintain consistent coding style
3. Test changes thoroughly
4. Update documentation as needed

## License

The script launchers are part of the Cangjie Extension project and follow the same license terms.
