// scripts/build-grammar.js
import { existsSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { execSync, spawnSync } from "child_process";

// 获取当前文件的目录路径，替代 __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

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

      // 智能WASM构建
      console.log("🌐 Attempting WASM build (optional)...");
      
      // 检查可用的构建工具
      const hasEmcc = isCommandAvailable("emcc");
      const hasDocker = isCommandAvailable("docker");
      const hasPodman = isCommandAvailable("podman");
      
      if (hasEmcc) {
        console.log("✅ Using emcc for WASM build");
        try {
          execSync("npx tree-sitter build --wasm", {
            cwd: grammarDir,
            stdio: "inherit",
          });
          console.log("✅ WASM build completed successfully");
        } catch (wasmError) {
          console.error("❌ WASM build failed with emcc:", wasmError.message);
          console.error("📝 Tip: Try updating emcc to the latest version");
        }
      } else if (hasDocker) {
        console.log("🐳 Using Docker for WASM build");
        try {
          execSync(`docker run --rm -v "${grammarDir}:/src" emscripten/emsdk bash -c "cd /src && npx tree-sitter build --wasm"`, {
            cwd: grammarDir,
            stdio: "inherit",
          });
          console.log("✅ WASM build completed successfully with Docker");
        } catch (wasmError) {
          console.error("❌ WASM build failed with Docker:", wasmError.message);
          console.error("📝 Tip: Ensure Docker is running and you have permission to use it");
        }
      } else if (hasPodman) {
        console.log("🐋 Using Podman for WASM build");
        try {
          execSync(`podman run --rm -v "${grammarDir}:/src" emscripten/emsdk bash -c "cd /src && npx tree-sitter build --wasm"`, {
            cwd: grammarDir,
            stdio: "inherit",
          });
          console.log("✅ WASM build completed successfully with Podman");
        } catch (wasmError) {
          console.error("❌ WASM build failed with Podman:", wasmError.message);
          console.error("📝 Tip: Ensure Podman is running and you have permission to use it");
        }
      } else {
        console.warn("⚠️  Skipping WASM build: No suitable tools found");
        console.warn("📝 To build WASM, install one of:");
        console.warn("   - Emscripten SDK: https://emscripten.org/docs/getting_started/downloads.html");
        console.warn("   - Docker: https://www.docker.com/get-started");
        console.warn("   - Podman: https://podman.io/getting-started/installation");
        console.warn("   WASM build is optional and not required for basic functionality");
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
