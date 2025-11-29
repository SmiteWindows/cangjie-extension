// build.rs
use std::env;
use std::fs;
use std::path::Path;

// 从 toolchain.json 读取 WASI SDK 版本的辅助函数
fn read_wasi_sdk_version() -> Result<String, Box<dyn std::error::Error>> {
    let toolchain_path = Path::new("toolchain.json");
    if toolchain_path.exists() {
        let toolchain_content = fs::read_to_string(toolchain_path)?;
        let toolchain: serde_json::Value = serde_json::from_str(&toolchain_content)?;
        if let Some(wasi_sdk_version) = toolchain["versions"]["wasiSdk"].as_str() {
            return Ok(wasi_sdk_version.to_string());
        }
    }
    Err("Failed to read wasiSdk version from toolchain.json".into())
}

fn main() {
    // 获取当前目录
    let current_dir = env::current_dir().unwrap();
    // 设置 tree-sitter-cangjie 目录路径
    let tree_sitter_cangjie_dir = current_dir.join("tree-sitter-cangjie");
    // 设置 src 目录路径
    let src_dir = tree_sitter_cangjie_dir.join("src");

    // 创建 cc 构建配置
    let mut c_config = cc::Build::new();
    c_config.file(src_dir.join("parser.c"))
        .file(src_dir.join("scanner.c"))
        .include(src_dir);

    // Get the target triple
    let target = env::var("TARGET").unwrap_or_default();
    
    // Configure for wasm32-wasip2 target using WASI SDK
    if target == "wasm32-wasip2" {
        // 从 toolchain.json 读取 WASI SDK 版本
        let wasi_sdk_version = read_wasi_sdk_version().unwrap_or_else(|_| "29.0".to_string());
        
        // Get WASI SDK path from environment variable or use default
        let wasi_sdk_path = env::var("WASI_SDK_PATH").unwrap_or_else(|_| {
            // Default paths for different platforms with dynamic version
            if cfg!(target_os = "windows") {
                format!("C:/opt/wasi-sdk-{}", wasi_sdk_version)
            } else {
                format!("/opt/wasi-sdk-{}", wasi_sdk_version)
            }
        });
        
        // Set the compiler to use wasi-sdk's clang
        let clang_path = if cfg!(target_os = "windows") {
            format!("{}/bin/clang.exe", wasi_sdk_path)
        } else {
            format!("{}/bin/clang", wasi_sdk_path)
        };
        
        c_config.compiler(clang_path);
        
        // Add WASI SDK include paths
        c_config.include(format!("{}/share/wasi-sysroot/include", wasi_sdk_path));
        
        // Set the target explicitly
        c_config.flag(format!("--target={}", target));
        
        // Add WASI-specific flags
        c_config.flag("-nostdlib");
        c_config.flag("-fvisibility=hidden");
        c_config.flag("-fPIC");
    }

    // 编译 parser.c 和 scanner.c
    c_config.compile("tree-sitter-cangjie");
    // 监视相关文件变化
    println!("cargo:rerun-if-changed=src/");
    println!("cargo:rerun-if-changed=tree-sitter-cangjie/");
}