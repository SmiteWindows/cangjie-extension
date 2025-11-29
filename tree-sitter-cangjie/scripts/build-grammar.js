// scripts/build-grammar.js
const { existsSync, readFileSync, writeFileSync, copyFileSync } = require("fs");
const { join, dirname } = require("path");
const { execSync, spawnSync } = require("child_process");

// 获取当前文件的目录路径
// 在CommonJS模块中，__filename和__dirname是全局变量

// 解析命令行参数
const args = process.argv.slice(2);
const options = {
  onlyWasm: args.includes('--only-wasm')
};

/**
 * 检查命令是否可用
 * @param {string} command - 要检查的命令
 * @returns {boolean} - 命令是否可用
 */
function isCommandAvailable(command) {
  try {
    // 在Windows上，使用shell=true可以正确检测到命令
    const result = spawnSync(command, ["--version"], {
      stdio: "ignore",
      shell: process.platform === "win32"
    });
    return result.status === 0;
  } catch {
    try {
        // 尝试使用which/where命令检查
        const checkCommand = process.platform === "win32" ? "where" : "which";
        const result = spawnSync(checkCommand, [command], {
          stdio: "ignore",
          shell: process.platform === "win32"
        });
        return result.status === 0;
      } catch {
        // 对于wasm-pack，我们需要检查它是否真的可用
        if (command === "wasm-pack") {
          try {
            const result = spawnSync("wasm-pack", ["--version"], {
              stdio: "ignore",
              shell: process.platform === "win32"
            });
            return result.status === 0;
          } catch {
            return false;
          }
        }
        return false;
      }
  }
}

/**
 * 智能构建Tree-sitter语法
 */
function buildTreeSitterGrammar() {
  try {
    const grammarDir = join(__dirname, "..");

    if (existsSync(grammarDir)) {
      if (!options.onlyWasm) {
        // 生成解析器
        console.log("📦 Generating tree-sitter parser...");
        execSync("npx tree-sitter generate", {
          cwd: grammarDir,
          stdio: "inherit",
        });

        // 构建解析器
        console.log("🔨 Building parser...");
        execSync("npx tree-sitter build", {
          cwd: grammarDir,
          stdio: "inherit",
        });
      }

      // Rust WASM构建
      console.log("🌐 Building Rust WASM...");
      
      try {
        // 检查Rust是否可用
        if (isCommandAvailable("cargo")) {
          console.log("✅ Using Rust for WASM build");
          
          // 构建WASI WASM (用于服务器端)
          console.log("🔧 Building WASI WASM...");
          execSync("cargo build --target wasm32-wasip2 --release", {
            cwd: grammarDir,
            stdio: "inherit",
          });
          
          // 生成WASM文件
          console.log("🔧 Generating WASM file...");
          
          // 尝试使用wasm-pack生成WASM文件
          try {
            console.log("🚀 Building WASM with wasm-pack...");
            
            // 配置Cargo.toml以支持wasm-pack
            const cargoTomlPath = join(grammarDir, "Cargo.toml");
            let cargoTomlContent = readFileSync(cargoTomlPath, "utf8");
            
            // 添加wasm-bindgen依赖（如果不存在）
            if (!cargoTomlContent.includes("wasm-bindgen")) {
              console.log("📝 Adding wasm-bindgen dependency to Cargo.toml...");
              cargoTomlContent += `
[dependencies]
wasm-bindgen = "0.2"
`;
              writeFileSync(cargoTomlPath, cargoTomlContent);
            }
            
            // 使用wasm-pack生成WASM文件，启用wasm特性
            // 设置环境变量，确保wasm-pack能够找到wasi-sdk
            const env = { ...process.env };
            // 如果没有设置WASI_SDK_PATH，从toolchain.json读取版本并设置默认值
            if (!env.WASI_SDK_PATH) {
              let wasiSdkVersion = "29.0";
              try {
                const toolchainPath = join(__dirname, "..", "toolchain.json");
                if (existsSync(toolchainPath)) {
                  const toolchainContent = readFileSync(toolchainPath, "utf8");
                  const toolchain = JSON.parse(toolchainContent);
                  if (toolchain.versions && toolchain.versions.wasiSdk) {
                    wasiSdkVersion = toolchain.versions.wasiSdk;
                  }
                }
              } catch (error) {
                console.warn("⚠️  Failed to read wasiSdk version from toolchain.json, using default:", error.message);
              }
              env.WASI_SDK_PATH = process.platform === "win32" 
                ? `C:/opt/wasi-sdk-${wasiSdkVersion}` 
                : `/opt/wasi-sdk-${wasiSdkVersion}`;
            }
            
            // 使用环境变量禁用wasm-opt，避免下载binaryen
            env.WASM_BINDGEN_WASM_OPT = "-O0";
            
            // 调试：输出wasm-pack路径
            console.log("🔍 Finding wasm-pack path...");
            let wasmPackPath = "wasm-pack";
            
            // 在Windows上，尝试使用完整的wasm-pack路径
            if (process.platform === "win32") {
              try {
                // 先尝试使用where命令查找wasm-pack路径
                const whereResult = spawnSync("where", ["wasm-pack"], { 
                  stdio: "pipe",
                  shell: true
                });
                if (whereResult.status === 0) {
                  // 从where结果中过滤掉node_modules路径，只使用全局路径
                  const wasmPackPaths = whereResult.stdout.toString().trim().split("\n");
                  // 找到第一个不在node_modules中的路径
                  const globalWasmPackPath = wasmPackPaths.find(path => !path.includes("node_modules"));
                  if (globalWasmPackPath) {
                    wasmPackPath = globalWasmPackPath;
                    console.log(`✅ Found global wasm-pack at: ${wasmPackPath}`);
                  } else {
                    // 如果没有找到全局路径，使用第一个找到的路径
                    wasmPackPath = wasmPackPaths[0];
                    console.log(`⚠️  Only found wasm-pack in node_modules at: ${wasmPackPath}`);
                  }
                }
              } catch (e) {
                console.warn("⚠️  Failed to find wasm-pack with where command");
              }
            }
            
            // 执行wasm-pack命令，使用找到的路径
            execSync(`${wasmPackPath} build --target web --release --features wasm`, {
              cwd: grammarDir,
              stdio: "inherit",
              env: env,
              shell: true
            });
            
            // 检查生成的WASM文件
            const wasmPath = join(grammarDir, "pkg", "tree_sitter_cangjie_bg.wasm");
            if (existsSync(wasmPath)) {
              // 复制到tree-sitter-cangjie目录
              const destWasmPathInTreeSitter = join(grammarDir, "tree-sitter-cangjie.wasm");
              copyFileSync(wasmPath, destWasmPathInTreeSitter);
              
              console.log("✅ WASM file built successfully and copied to tree-sitter-cangjie directory");
            } else {
              console.error("❌ WASM file not found after wasm-pack build");
              throw new Error("WASM file not generated");
            }
          } catch (wasmError) {
            console.error("❌ Failed to generate WASM file with wasm-pack:", wasmError.message);
            console.error("📝 Tip: Check if wasm-pack is properly installed and try again");
            
            // 尝试使用Rust直接生成WASM文件
            console.log("🔄 Trying to generate WASM file directly with Rust...");
            try {
              // 构建WASI WASM
              execSync("cargo build --target wasm32-wasip2 --release", {
                cwd: grammarDir,
                stdio: "inherit"
              });
              
              // 构建Web WASM
              execSync("cargo build --target wasm32-unknown-unknown --release", {
                cwd: grammarDir,
                stdio: "inherit"
              });
              
              console.log("✅ Rust WASM build completed successfully");
            } catch (rustWasmError) {
              console.error("❌ Failed to generate WASM file with Rust:", rustWasmError.message);
              console.error("📝 Tip: Ensure Rust is installed and up-to-date");
              console.error("   Run 'rustup update' to update Rust");
              console.error("   Run 'rustup target add wasm32-wasip2 wasm32-unknown-unknown' to add WASM targets");
            }
          }
          
          console.log("✅ Rust WASM build completed successfully");
        } else {
          console.warn("⚠️  Skipping Rust WASM build: cargo not found");
          console.warn("📝 To build Rust WASM, install Rust: https://www.rust-lang.org/tools/install");
          console.warn("   Rust WASM build is optional and not required for basic functionality");
        }
      } catch (wasmError) {
        console.error("❌ Rust WASM build failed:", wasmError.message);
        console.error("📝 Tip: Ensure Rust is installed and up-to-date");
        console.error("   Run 'rustup update' to update Rust");
        console.error("   Run 'rustup target add wasm32-wasip2 wasm32-unknown-unknown' to add WASM targets");
      }
    } else {
      console.error("❌ Error: tree-sitter-cangjie directory not found");
      console.error("📝 Tip: Ensure the tree-sitter-cangjie submodule is properly initialized");
      process.exitCode = 1;
    }
  } catch (error) {
    console.error("❌ Error building tree-sitter grammar:", error.message);
    console.error("📝 Tip: Check if all dependencies are installed (npm install)");
    process.exitCode = 1;
  }
}

buildTreeSitterGrammar();
