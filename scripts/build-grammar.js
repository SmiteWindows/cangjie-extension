// scripts/build-grammar.js
import { existsSync, copyFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { execSync } from "child_process";

// 获取当前文件的目录路径，替代 __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function buildTreeSitterGrammar() {
  try {
    const grammarDir = join(__dirname, "..", "tree-sitter-cangjie");

    if (existsSync(grammarDir)) {
      // 生成解析器
      console.log("Generating tree-sitter parser...");
      execSync("npx tree-sitter generate", {
        cwd: grammarDir,
        stdio: "inherit",
      });

      // 构建解析器
      console.log("Building parser...");
      execSync("npx tree-sitter build", {
        cwd: grammarDir,
        stdio: "inherit",
      });

      // 尝试WASM构建，优雅处理失败
      console.log("Attempting WASM build (optional)...");
      try {
        execSync("npx tree-sitter build --wasm", {
          cwd: grammarDir,
          stdio: "inherit",
        });
      } catch (wasmError) {
        console.warn("WASM build failed (optional feature, may require emcc/docker):", wasmError.message);
      }
    } else {
      console.error("Error: tree-sitter-cangjie directory not found, skipping grammar build");
      process.exitCode = 1;
    }
  } catch (error) {
    console.error("Error building tree-sitter grammar:", error.message);
    process.exitCode = 1;
  }
}

buildTreeSitterGrammar();
