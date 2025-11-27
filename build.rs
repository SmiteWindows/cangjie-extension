// build.rs
use std::env;

fn main() {
    // 获取当前目录
    let current_dir = env::current_dir().unwrap();
    // 设置 tree-sitter-cangjie 目录路径
    let tree_sitter_cangjie_dir = current_dir.join("tree-sitter-cangjie");
    // 设置 src 目录路径
    let src_dir = tree_sitter_cangjie_dir.join("src");

    // 编译 parser.c 和 scanner.c
    cc::Build::new()
        .file(src_dir.join("parser.c"))
        .file(src_dir.join("scanner.c"))
        .include(src_dir)
        .compile("tree-sitter-cangjie");
}