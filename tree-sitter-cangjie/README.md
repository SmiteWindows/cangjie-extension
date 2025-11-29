# Tree-sitter Cangjie

Cangjie language grammar for tree-sitter.

## Description

This repository contains the Tree-sitter grammar for the Cangjie programming language. It provides syntax highlighting, code folding, and other language features for editors and tools that support Tree-sitter, including Zed, Neovim, Emacs, and more.

## Features

- **Syntax Highlighting**: Comprehensive syntax highlighting for Cangjie code
- **Code Folding**: Support for folding code blocks
- **Navigation Support**: Enable navigation between symbols and definitions
- **Incremental Parsing**: Efficiently updates the parse tree when only part of the code changes
- **Language Injection Support**: Allows embedding other languages within Cangjie code
- **WASM Support**: Can be compiled to WebAssembly for use in web applications
- **Multi-language Bindings**: Available for Node.js, Rust, Python, Go, and more

## Installation

### For Node.js

```bash
npm install tree-sitter-cangjie
```

### For Rust

```toml
[dependencies]
tree-sitter = "^0.25.0"
tree-sitter-cangjie = { git = "https://github.com/SmiteWindows/cangjie-extension" }
```

### For Python

```bash
pip install tree-sitter-cangjie
```

### For Go

```bash
go get github.com/SmiteWindows/cangjie-extension/tree-sitter-cangjie
```

## Usage

### In Zed Editor

The Tree-sitter Cangjie grammar is used by the [Cangjie extension for Zed](https://github.com/SmiteWindows/cangjie-extension) to provide syntax highlighting and language intelligence features. Simply install the extension from the Zed extensions marketplace.

### In Neovim

Add the following to your `init.lua`:

```lua
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cangjie = {
  install_info = {
    url = "https://github.com/SmiteWindows/cangjie-extension",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  filetype = "cj",
}

-- Enable highlighting
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
```

### In Other Editors

Refer to your editor's documentation for information on how to use Tree-sitter grammars.

### WebAssembly Usage

The grammar can be compiled to WebAssembly for use in web applications:

```javascript
import { LANGUAGE } from './tree-sitter-cangjie.wasm';

// Use the language in your web application
const parser = new Parser();
parser.setLanguage(LANGUAGE);
const tree = parser.parse("fn main() { println(\"Hello, world!\"); }", null);
```

## Development

### Prerequisites

- Node.js
- npm
- tree-sitter-cli
- Rust (for WASM build)
- wasm-pack (for WASM build)

### Installation

```bash
npm install
```

### Building

#### Generate Parser

```bash
tree-sitter generate
```

#### Build for Node.js

```bash
npm run build
```

#### Build for WebAssembly

```bash
# Build for web target
wasm-pack build --target web --release

# Build for node target
wasm-pack build --target nodejs --release
```

#### Build with Rust

```bash
# Build the Rust crate
cargo build

# Build for WASM target
cargo build --target wasm32-unknown-unknown --release
```

### Testing

#### Run Tree-sitter Tests

```bash
tree-sitter test
```

#### Run Rust Tests

```bash
cargo test
```

#### Run JavaScript Tests

```bash
npm test
```

### Running the Playground

```bash
npm start
```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT

## Authors

- [SmiteWindows](https://github.com/SmiteWindows/)

## Links

- [Cangjie Extension for Zed](https://github.com/SmiteWindows/cangjie-extension)
- [Cangjie Language Documentation](https://cangjie-lang.org/docs)
- [Tree-sitter Documentation](https://tree-sitter.github.io/tree-sitter/)
- [WebAssembly Documentation](https://webassembly.org/docs/)
- [Zed Editor](https://zed.dev/)
