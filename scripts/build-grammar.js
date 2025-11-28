// scripts/build-grammar.js
import { existsSync } from "fs";
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
    // 使用spawnSync避免shell注入，更安全
    const result = spawnSync(command, ["--version"], {
      stdio: "ignore",
      shell: false
    });
    return result.status === 0;
  } catch {
    try {
      // 尝试使用which/where命令检查
      const checkCommand = process.platform === "win32" ? "where" : "which";
      const result = spawnSync(checkCommand, [command], {
        stdio: "ignore",
        shell: false
      });
      return result.status === 0;
    } catch {
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
          
          // 复制WASI WASM到主目录
          const wasiWasmPath = join(grammarDir, "target", "wasm32-wasip2", "release", "tree_sitter_cangjie.wasm");
          if (existsSync(wasiWasmPath)) {
            const destWasmPath = join(__dirname, "..", "tree-sitter-cangjie.wasm");
            execSync(`cp "${wasiWasmPath}" "${destWasmPath}"`, {
              stdio: "inherit"
            });
            console.log("✅ WASI WASM built successfully");
          }
          
          // 构建Web WASM (用于浏览器)
          console.log("🔧 Building Web WASM...");
          execSync("cargo build --target wasm32-unknown-unknown --release", {
            cwd: grammarDir,
            stdio: "inherit",
          });
          
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
