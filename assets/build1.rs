// build.rs
use std::env;
use std::path::PathBuf;

fn main() {
    // 获取项目根目录
    let project_dir = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap());

    // 编译tree-sitter-cangjie解析器
    let tree_sitter_dir = project_dir.join("tree-sitter-cangjie");
    if tree_sitter_dir.exists() {
        let src_dir = tree_sitter_dir.join("src");
        if src_dir.exists() {
            let parser_file = src_dir.join("parser.c");
            if parser_file.exists() {
                cc::Build::new()
                    .file(&parser_file)
                    .include(&src_dir)
                    .compile("tree-sitter-cangjie");
            }

            // 如果有scanner.c也一起编译
            let scanner_file = src_dir.join("scanner.c");
            if scanner_file.exists() {
                cc::Build::new()
                    .file(&scanner_file)
                    .include(&src_dir)
                    .compile("tree-sitter-cangjie-scanner");
            }
        }
    }

    // 监视相关文件变化
    println!("cargo:rerun-if-changed=src/");
    println!("cargo:rerun-if-changed=tree-sitter-cangjie/");
    println!("cargo:rerun-if-changed=extension.json");
}
