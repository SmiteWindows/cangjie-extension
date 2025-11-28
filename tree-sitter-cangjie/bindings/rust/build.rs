fn main() {
    let src_dir = std::path::Path::new("src");

    let mut c_config = cc::Build::new();
    c_config.std("c17").include(src_dir);

    // Get the target triple
    let target = std::env::var("TARGET").unwrap_or_default();
    
    // Only add -utf-8 flag if we're building for Windows MSVC target and not WASM
    if target.contains("msvc") && !target.contains("wasm32") {
        c_config.flag("-utf-8");
    }
    
    // Configure for wasm32-wasip2 target using WASI SDK
    if target == "wasm32-wasip2" {
        // Get WASI SDK path from environment variable or use default
        let wasi_sdk_path = std::env::var("WASI_SDK_PATH").unwrap_or_else(|_| {
            // Default paths for different platforms
            if cfg!(target_os = "windows") {
                "C:/opt/wasi-sdk-29.0".to_string()
            } else {
                "/opt/wasi-sdk-29.0".to_string()
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

    let parser_path = src_dir.join("parser.c");
    c_config.file(&parser_path);
    println!("cargo:rerun-if-changed={}", parser_path.to_str().unwrap());

    let scanner_path = src_dir.join("scanner.c");
    if scanner_path.exists() {
        c_config.file(&scanner_path);
        println!("cargo:rerun-if-changed={}", scanner_path.to_str().unwrap());
    }

    c_config.compile("tree-sitter-cangjie");
}
