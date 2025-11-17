// scripts/build-grammar.js
import { existsSync, copyFileSync } from "fs";
import { join } from "path";
import { execSync } from "child_process";

function buildTreeSitterGrammar() {
  try {
    // 检查是否有tree-sitter CLI
    execSync("npm list -g tree-sitter-cli || npm install -g tree-sitter-cli", {
      stdio: "pipe",
    });

    const grammarDir = join(__dirname, "..", "tree-sitter-cangjie");

    if (existsSync(grammarDir)) {
      process.chdir(grammarDir);

      // 生成解析器
      console.log("Generating tree-sitter parser...");
      execSync("tree-sitter generate", { stdio: "inherit" });

      // 构建WASM版本
      console.log("Building WASM parser...");
      execSync("tree-sitter build-wasm", { stdio: "inherit" });

      // 复制到扩展目录
      const wasmFile = join(grammarDir, "tree-sitter-cangjie.wasm");
      const targetDir = join(__dirname, "..");
      const targetFile = join(targetDir, "tree-sitter-cangjie.wasm");

      if (existsSync(wasmFile)) {
        copyFileSync(wasmFile, targetFile);
        console.log("WASM parser copied to extension root");
      }
    } else {
      console.log(
        "tree-sitter-cangjie directory not found, skipping grammar build",
      );
    }
  } catch (error) {
    console.error("Error building tree-sitter grammar:", error.message);
  }
}

buildTreeSitterGrammar();
