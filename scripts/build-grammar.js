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

      // 构建解析器
      console.log("Building parser...");
      execSync("tree-sitter build", { stdio: "inherit" });
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
