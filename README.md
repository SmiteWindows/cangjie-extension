<!-- README.md -->
# Zed Cangjie Extension

This extension adds comprehensive support for the Cangjie programming language to the [Zed](https://zed.dev) editor.

## Features

### Core Features
* **Syntax Highlighting**: Advanced syntax highlighting powered by Tree-sitter grammar
* **Language Server Protocol (LSP)**: Integration for code completion, diagnostics, go-to-definition, references, etc.
* **Task Integration**: Build and run Cangjie projects using `cjpm` and `jc`
* **Debugging Support**: Debug Cangjie programs via `cjdb`
* **Slash Commands**: Quick info with `/cangjie-info`

### Enhanced Features
* **Code Snippets**: Smart code templates for functions, structs, classes, enums, and more
* **Custom Keyboard Shortcuts**: Optimized keyboard mappings for Cangjie development
* **Themes**: Custom syntax highlighting themes for better readability
* **Auto-completion**: Intelligent code suggestions based on context
* **Signature Help**: Function parameter hints
* **Symbol Navigation**: Quickly navigate to symbols in your codebase

## Requirements

* **Zed Editor**: Version 0.214.0 or later
* **Cangjie SDK**: [Cangjie SDK 1.0.4+](https://cangjie-lang.cn/download/1.0.4)

## Installation

### Option 1: Install from Zed Extension Market (Recommended)
1. Open Zed editor
2. Go to `Extensions > Browse Extensions`
3. Search for "Cangjie"
4. Click "Install" to install the extension
5. Enable the extension in `Extensions > Installed`

### Option 2: Manual Installation
1. Clone this repository into your Zed extensions directory:
   * Linux/macOS: `~/.config/zed/extensions/work/cangjie-extension`
   * Windows: `%APPDATA%\Zed\extensions\work\cangjie-extension`
2. Open Zed and enable the extension in `Extensions > Installed`

## Configuration

### SDK Configuration
The extension needs to know where your Cangjie SDK is located.

1. **Automatic Detection**: It will try to find the SDK in standard locations:
   * Windows: `C:\Program Files\Cangjie`, `D:\Program Files\Cangjie`
   * macOS/Linux: `/usr/local/cangjie`, `/opt/cangjie`

2. **Manual Configuration (Recommended)**: 
   Open your project's `settings.json` (via `Cmd/Ctrl + ,` or `Zed > Preferences > Open Settings`) and add:
   ```json
   {
     "cangjie": {
       "sdkPath": "/absolute/path/to/your/cangjie-sdk-directory"
     }
   }
   ```

### Tool Overrides
If you want to use custom tool paths:
```json
{
  "cangjie": {
    "sdkPath": "/path/to/sdk",
    "lspPathOverride": "/custom/path/to/my/LSPServer",
    "cjpmPathOverride": "/custom/path/to/my/cjpm"
  }
}
```

## Usage

### Basic Usage
* Open a `.cj` file to activate syntax highlighting
* The LSP will start automatically, providing features like auto-completion and error checking
* Use `Tasks > Run Task...` to build/run/test projects
* Use `Run > Start Debugging` to debug with `cjdb`
* Type `/cangjie-info` in the command palette for extension info

### Code Snippets
Type any of these prefixes and press `Tab` to expand:
* `func` - Create a new function
* `struct` - Create a new struct
* `class` - Create a new class
* `enum` - Create a new enum
* `let` - Create a new variable
* `var` - Create a new mutable variable
* `const` - Create a new constant
* `if` - Create an if statement
* `for` - Create a for loop
* `while` - Create a while loop

### Keyboard Shortcuts
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+Space` | Show completions |
| `Ctrl+Space` | Show signature help |
| `F12` | Go to definition |
| `Shift+F12` | Show references |
| `Ctrl+R` | Show symbol palette |
| `Ctrl+Shift+R` | Show workspace symbol palette |
| `Ctrl+\` | Toggle sidebar |
| `Ctrl+Shift+P` | Show command palette |
| `Ctrl+/` | Toggle line comment |
| `Ctrl+Shift+/` | Toggle block comment |
| `Alt+Down` | Move line down |
| `Alt+Up` | Move line up |
| `Shift+Alt+Down` | Copy line down |
| `Shift+Alt+Up` | Copy line up |
| `Ctrl+Shift+K` | Delete line |
| `Ctrl+Enter` | Insert line below |
| `Ctrl+Shift+Enter` | Insert line above |
| `Ctrl+D` | Select next occurrence |
| `Ctrl+Shift+L` | Select all occurrences |

### Themes
The extension includes a custom syntax highlighting theme. To use it:
1. Go to `Zed > Preferences > Theme`
2. Select "Cangjie Default" from the list

## Building from Source

### Prerequisites
* Node.js and npm
* Rust and Cargo
* Tree-sitter CLI

### Build Steps
1. Clone the repository
2. Install dependencies: `npm install`
3. Build the extension: `npm run build`
4. The built extension will be available in the `target` directory

### Available Scripts
* `npm run build` - Build the extension
* `npm run build-grammar` - Build the Tree-sitter grammar
* `npm run build-wasm` - Build the WASM module
* `npm run generate` - Generate the Tree-sitter parser
* `npm run test` - Run Tree-sitter tests
* `npm run test-rust` - Run Rust tests
* `npm run clean` - Clean generated files

## Contributing

Contributions are welcome! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for guidelines.

## License

This extension is licensed under the [MIT License](LICENSE).

## Support

If you encounter any issues or have questions, please:
1. Check the [documentation](docs/)
2. Open an issue on the [GitHub repository](https://gitcode.com/Cangjie/cangjie_test/issues)
3. Join the Cangjie community for support

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.

## Roadmap

* [ ] Better error reporting
* [ ] More comprehensive code snippets
* [ ] Improved debugging experience
* [ ] Integration with more Cangjie tools
* [ ] Support for more advanced language features

---

**Enjoy coding in Cangjie with Zed!**