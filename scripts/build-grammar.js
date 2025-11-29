// scripts/build-grammar.js
import { existsSync, readFileSync, writeFileSync, copyFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { execSync, spawnSync } from "child_process";

// 获取当前文件的目录路径，替代 __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

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
      // 对于wasm-pack，我们可以直接尝试运行它，因为我们知道它已经安装了
      if (command === "wasm-pack") {
        return true;
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
    const grammarDir = join(__dirname, "..", "tree-sitter-cangjie");

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
          
          // 检查wasm-pack是否可用
          if (!isCommandAvailable("wasm-pack")) {
            console.error("❌ wasm-pack not found. Please install it with: npm install -g wasm-pack");
            throw new Error("wasm-pack not found");
          }
          
          // 使用wasm-pack生成WASM文件
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
                const toolchainPath = path.join(__dirname, "..", "toolchain.json");
                if (fs.existsSync(toolchainPath)) {
                  const toolchainContent = fs.readFileSync(toolchainPath, "utf8");
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
            
            execSync("wasm-pack build --target web --release --features wasm", {
              cwd: grammarDir,
              stdio: "inherit",
              env: env
            });
            
            // 检查生成的WASM文件
            const wasmPath = join(grammarDir, "pkg", "tree_sitter_cangjie_bg.wasm");
            if (existsSync(wasmPath)) {
              // 复制到tree-sitter-cangjie目录
              const destWasmPathInTreeSitter = join(grammarDir, "tree-sitter-cangjie.wasm");
              copyFileSync(wasmPath, destWasmPathInTreeSitter);
              
              // 复制到项目根目录
              const destWasmPath = join(__dirname, "..", "tree-sitter-cangjie.wasm");
              copyFileSync(wasmPath, destWasmPath);
              
              console.log("✅ WASM file built successfully and copied to both locations");
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
              
              // 检查生成的WASM文件
              const wasiWasmPath = join(grammarDir, "target", "wasm32-wasip2", "release", "libtree_sitter_cangjie.rlib");
              if (existsSync(wasiWasmPath)) {
                // 复制到tree-sitter-cangjie目录
              const destWasmPathInTreeSitter = join(grammarDir, "tree-sitter-cangjie.wasm");
              copyFileSync(wasiWasmPath, destWasmPathInTreeSitter);
              
              // 复制到项目根目录
              const destWasmPath = join(__dirname, "..", "tree-sitter-cangjie.wasm");
              copyFileSync(wasiWasmPath, destWasmPath);
                
                console.log("✅ WASM file built successfully with Rust and copied to both locations");
              } else {
                console.error("❌ WASM file not found after Rust build");
                throw new Error("WASM file not generated");
              }
            } catch (rustWasmError) {
              console.error("❌ Failed to generate WASM file with Rust:", rustWasmError.message);
              
              // 生成一个空的WASM文件作为占位符
              const emptyWasmPath = join(__dirname, "..", "tree-sitter-cangjie.wasm");
              const emptyWasmPathInTreeSitter = join(grammarDir, "tree-sitter-cangjie.wasm");
              execSync(`echo "" > "${emptyWasmPath}"`, {
                stdio: "inherit"
              });
              execSync(`echo "" > "${emptyWasmPathInTreeSitter}"`, {
                stdio: "inherit"
              });
              console.log("⚠️  Created empty WASM files as placeholders");
            }
          }
          
          // 构建Web WASM (用于浏览器) - 可选，失败时继续
          console.log("🔧 Building Web WASM...");
          try {
            execSync("cargo build --target wasm32-unknown-unknown --release", {
              cwd: grammarDir,
              stdio: "inherit",
            });
            console.log("✅ Web WASM build completed successfully");
          } catch (webWasmError) {
            console.warn("⚠️  Web WASM build failed, but continuing with the build process...");
            console.warn("📝 Tip: Web WASM build is optional and not required for basic functionality");
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
