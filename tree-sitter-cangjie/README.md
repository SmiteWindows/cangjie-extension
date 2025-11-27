# Tree-sitter Cangjie

Cangjie language grammar for tree-sitter.

## Description

This repository contains the Tree-sitter grammar for the Cangjie programming language. It provides syntax highlighting, code folding, and other language features for editors and tools that support Tree-sitter.

## Features

- Syntax highlighting
- Code folding
- Navigation support
- Incremental parsing
- Language injection support

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

## Development

### Prerequisites

- Node.js
- npm
- tree-sitter-cli

### Installation

```bash
npm install
```

### Building

```bash
tree-sitter generate
```

### Testing

```bash
tree-sitter test
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

- [Cangjie Language](https://github.com/SmiteWindows/cangjie-extension)
- [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
