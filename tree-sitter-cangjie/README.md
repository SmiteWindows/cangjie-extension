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
tree-sitter-cangjie = { git = "https://github.com/SmiteWindows/tree-sitter-cangjie", branch = "main" }
```

### For Python

```bash
pip install tree-sitter-cangjie
```

### For Go

```bash
go get github.com/SmiteWindows/tree-sitter-cangjie
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
    url = "https://github.com/SmiteWindows/tree-sitter-cangjie",
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
const Parser = require('tree-sitter');
const Cangjie = require('./tree-sitter-cangjie.wasm');

// Use the language in your application
const parser = new Parser();
parser.setLanguage(Cangjie);
const tree = parser.parse("fn main() { println(\"Hello, world!\"); }", null);
```

## Development

### Prerequisites

- Node.js
- npm
- tree-sitter-cli
- Rust (for WASM build)
- wasm-pack (for WASM build, will be installed via cargo if not present)

### Installation

```bash
npm install
```

### Building

#### Generate Parser

```bash
npm run generate
```

#### Build for Node.js

```bash
npm run build
```

#### Build for WebAssembly

```bash
# Build all WASM targets
npm run build-wasm

# Build for web target
npm run build-wasm-web

# Build for WASI target
npm run build-wasm-rust
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
npm run test
```

#### Run Rust Tests

```bash
npm run test-rust
```

#### Run JavaScript Tests

```bash
npm run test:node
```

### Running the Playground

```bash
npm start
```

### Available Scripts

* `npm run build` - Build the extension
* `npm run build-grammar` - Build the Tree-sitter grammar
* `npm run build-wasm` - Build all WASM targets
* `npm run build-wasm-web` - Build WASM for web target
* `npm run build-wasm-rust` - Build WASM for WASI target
* `npm run generate` - Generate the Tree-sitter parser
* `npm run test` - Run Tree-sitter tests
* `npm run test-rust` - Run Rust tests
* `npm run test:node` - Run Node.js tests
* `npm run clean` - Clean generated files
* `npm start` - Start Tree-sitter playground

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT

## Authors

- [SmiteWindows](https://github.com/SmiteWindows/)

## Links

- [Cangjie Extension for Zed](https://github.com/SmiteWindows/cangjie-extension)
- [Tree-sitter Documentation](https://tree-sitter.github.io/tree-sitter/)
- [WebAssembly Documentation](https://webassembly.org/docs/)
- [Zed Editor](https://zed.dev/)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each version.