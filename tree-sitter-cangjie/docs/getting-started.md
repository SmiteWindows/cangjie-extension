<!-- docs/getting-started.md -->
# Getting Started with Cangjie Extension

This guide will help you get started with the Cangjie extension for Zed editor.

## Installation

### Prerequisites

- Zed editor version 0.214.0 or later
- Cangjie SDK (optional, but recommended for full functionality)

### Installing the Extension

1. Open Zed editor
2. Go to Extensions (Cmd+Shift+X on macOS, Ctrl+Shift+X on Windows/Linux)
3. Search for "Cangjie"
4. Click the Install button
5. Wait for the installation to complete
6. Restart Zed to activate the extension

## Configuration

### Setting Up the Cangjie SDK

If you have the Cangjie SDK installed, you can configure the extension to use it:

1. Go to Zed settings (Cmd+, on macOS, Ctrl+, on Windows/Linux)
2. Search for "Cangjie"
3. Set the `sdkPath` option to the path of your Cangjie SDK installation
4. Save the settings
5. Restart Zed for the changes to take effect

### Editor Settings

The extension uses 4-space indentation and soft tabs by default. You can customize these settings in your Zed configuration:

```json
{
  "languages": {
    "Cangjie": {
      "indent": {
        "tab_size": 4,
        "use_tabs": false
      }
    }
  }
}
```

## First Steps

### Creating Your First Cangjie File

1. Open Zed editor
2. Create a new file (Cmd+N on macOS, Ctrl+N on Windows/Linux)
3. Save the file with a `.cj` extension (e.g., `hello.cj`)
4. Start writing Cangjie code

### Hello World Example

```cangjie
// Hello World example
fn main() {
    println("Hello, Cangjie!");
}
```

### Running Your First Program

1. Open the file you created
2. Press Cmd+Shift+B (macOS) or Ctrl+Shift+B (Windows/Linux) to open the task menu
3. Select "Run Cangjie Program"
4. View the output in the terminal

### Building Your Project

If you're working on a larger project, you can use the build task:

1. Open the project directory in Zed
2. Press Cmd+Shift+B (macOS) or Ctrl+Shift+B (Windows/Linux) to open the task menu
3. Select "Build Cangjie Project"
4. View the build output in the terminal

## Using the Language Server

The Cangjie extension provides advanced code intelligence features through the Cangjie Language Server:

### Code Completion

As you type, the extension will provide smart suggestions for variables, functions, and types.

### Go to Definition

To jump to the definition of a symbol:

1. Place the cursor on the symbol
2. Press Cmd+Click (macOS) or Ctrl+Click (Windows/Linux)

### Find References

To find all references to a symbol:

1. Place the cursor on the symbol
2. Press Cmd+Shift+F (macOS) or Ctrl+Shift+F (Windows/Linux)

### Hover Documentation

To view documentation for a symbol:

1. Place the cursor on the symbol
2. Hover over it with your mouse

## Debugging Your Code

The extension provides integrated debugging support for Cangjie programs:

### Setting Up a Launch Configuration

1. Go to the Debug panel (Cmd+Shift+D on macOS, Ctrl+Shift+D on Windows/Linux)
2. Click "Create a launch.json file"
3. Select "Cangjie" from the dropdown
4. Customize the launch configuration as needed

### Starting a Debug Session

1. Set breakpoints by clicking in the gutter next to the line numbers
2. Click the "Start Debugging" button
3. Use the debug controls to step through your code
4. View variables and the call stack in the debug panel

## Troubleshooting

### Extension Not Working

If the extension is not working properly:

1. Check that you're using Zed version 0.214.0 or later
2. Verify that the Cangjie SDK is properly installed and configured
3. Check the Zed logs for any error messages
4. Try reinstalling the extension

### Language Server Not Starting

If the language server is not starting:

1. Verify that the `sdkPath` is correctly configured
2. Check that the Cangjie SDK is properly installed
3. Check the Zed logs for any error messages

## Additional Resources

- [Cangjie Language Documentation](https://cangjie-lang.org/docs)
- [Cangjie SDK Installation Guide](https://cangjie-lang.org/docs/getting-started/install)
- [Cangjie Language Server Documentation](https://cangjie-lang.org/docs/tools/language-server)

## Getting Help

If you have any questions or issues with the extension:

1. Check the [Cangjie Community Forum](https://forum.cangjie-lang.org)
2. Report issues on the [GitHub repository](https://github.com/SmiteWindows/cangjie-extension)
3. Join the [Cangjie Discord Server](https://discord.gg/cangjie-lang)
