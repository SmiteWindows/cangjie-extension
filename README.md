<!-- README.md -->
# Zed Cangjie Extension

This extension adds support for the Cangjie programming language to the [Zed](https://zed.dev) editor.

## Features

* Syntax Highlighting (requires `tree-sitter-cangjie` grammar)
* Language Server Protocol (LSP) integration for code completion, diagnostics, go-to-definition, etc.
* Task integration for building and running Cangjie projects (`cjpm`, `jc`).
* Debugging support via `cjdb`.
* Slash commands for quick info (`/cangjie-info`).

## Requirements

* The [Cangjie SDK](https://cangjie-lang.cn/download/1.0.4) must be installed.
* The Zed editor.

## Installation

1. Clone this repository into your Zed extensions directory (usually `~/.config/zed/extensions/work` on Linux/macOS or `%APPDATA%\Zed\extensions\work` on Windows).
2. Open Zed, go to `Extensions > Installed`. You should see the Cangjie extension listed.
3. Enable the extension.

## Configuration

The extension needs to know where your Cangjie SDK is located.

1.  **Automatic Detection:** It will try to find the SDK in standard installation locations:
    *   Windows: `C:\Program Files\Cangjie`, `D:\Program Files\Cangjie`, etc.
    *   macOS/Linux: `/usr/local/cangjie`, `/opt/cangjie`, etc.
2.  **Manual Configuration (Recommended):**
    Open your project's `settings.json` (accessible via `Cmd/Ctrl + ,` or `Zed > Preferences > Open Settings`) and add the path to your SDK:

    ```json
    {
      "cangjie": {
        "sdkPath": "/absolute/path/to/your/cangjie-sdk-directory"
      }
    }
    ```
    Replace `/absolute/path/to/your/cangjie-sdk-directory` with the actual path to the root of your downloaded/installed Cangjie SDK (the folder containing `bin`, `lib`, etc.).

    **Optional Tool Overrides:**
    If you want to use a different version of a specific tool (e.g., a development build of `LSPServer`), you can specify its path directly:

    ```json
    {
      "cangjie": {
        "sdkPath": "/path/to/sdk",
        "lspPathOverride": "/custom/path/to/my/LSPServer",
        "cjpmPathOverride": "/custom/path/to/my/cjpm"
        // ... other overrides
      }
    }
    ```

## Usage

*   Open a `.cj` file. Syntax highlighting should activate.
*   The LSP should start automatically, providing features like auto-completion and error checking.
*   Use `Tasks > Run Task...` (or the configured shortcut) to access build/run/test commands.
*   Use `Run > Start Debugging` (or the configured shortcut) to debug your programs with `cjdb`.
*   Type `/cangjie-info` in the command palette (`Cmd/Ctrl + Shift + P`) to see the resolved paths used by the extension.
