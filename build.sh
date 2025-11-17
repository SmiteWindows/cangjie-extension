#!/bin/bash
# build.sh - 构建脚本

set -e

echo "Building Cangjie extension for Zed..."

# 检查Rust工具链
if ! command -v rustc &> /dev/null; then
    echo "Rust is not installed. Please install Rust from https://rustup.rs/"
    exit 1
fi

# 检查Cargo
if ! command -v cargo &> /dev/null; then
    echo "Cargo is not installed. Please install Rust from https://rustup.rs/"
    exit 1
fi

# 构建扩展
echo "Building extension..."
cargo build --release

# 构建tree-sitter语法
echo "Building tree-sitter grammar..."
node scripts/build-grammar.js

echo "Build completed successfully!"
echo "The extension is ready to be loaded in Zed."
