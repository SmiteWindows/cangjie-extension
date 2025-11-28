# Cangjie Extension 配置使用文档

## 1. 项目概述

Cangjie Extension 是为 Zed 编辑器提供的 Cangjie 编程语言支持扩展，包含语法高亮、LSP 支持、调试功能等。

### 核心功能
- 语法高亮（基于 Tree-sitter）
- 语言服务器协议（LSP）集成
- 任务集成（构建和运行 Cangjie 项目）
- 调试支持
- 代码片段
- 自定义键盘快捷键
- 主题支持

## 2. 开发环境配置

### 2.1 系统要求
- Node.js 和 npm（用于构建脚本）
- Rust 和 Cargo（用于编译 Rust 代码和 WASM）
- Tree-sitter CLI（用于生成和构建语法解析器）
- Cangjie SDK 1.0.4+（用于开发和测试）

### 2.2 依赖安装

#### 安装 Node.js 依赖
```bash
npm install
```

#### 安装 Rust 目标
```bash
rustup target add wasm32-wasip2 wasm32-unknown-unknown
```

#### 安装 Tree-sitter CLI
```bash
npm install -g tree-sitter-cli
```

#### 安装 Cangjie SDK

**Linux/macOS**：
```bash
curl -sSf https://cangjie-lang.cn/download/1.0.4 | sudo tar -xzf - -C /usr/local
```

**Windows**：
```powershell
Invoke-WebRequest -Uri https://cangjie-lang.cn/download/1.0.4 -OutFile cangjie-sdk.zip
Expand-Archive -Path cangjie-sdk.zip -DestinationPath "C:\Program Files\Cangjie" -Force
```

## 3. 项目配置文件

### 3.1 extension.toml

扩展的主要配置文件，定义了扩展的元数据和功能。

```toml
[extension]
id = "cangjie.cangjie"
name = "Cangjie"
version = "0.1.0"
schema_version = 1
description = "Cangjie language support for Zed editor"
authors = ["Cangjie Team <team@cangjie-lang.org>"]
repository = "https://github.com/SmiteWindows/cangjie-extension"
license = "MIT"
categories = ["language", "programming"]
min_zed_version = "0.214.0"
languages = ["Cangjie"]
capabilities = []
file_types = ["cj"]

# 语法分析器配置
[grammars.cangjie]
path = "tree-sitter-cangjie"
scope = "source.cangjie"
file_types = ["cj"]

# 语言服务器配置
[language_servers.cangjie-lsp]
name = "Cangjie Language Server"
languages = ["Cangjie"]
command = "cangjie-lsp"
args = ["--stdio"]

[language_servers.cangjie-lsp.language_ids]
"Cangjie" = "cangjie"
```

### 3.2 package.json

定义了构建脚本和依赖。

```json
{
  "name": "cangjie-extension",
  "version": "0.1.0",
  "type": "module",
  "description": "Cangjie language support for Zed editor",
  "scripts": {
    "build": "npm run build-grammar",
    "build-grammar": "node scripts/build-grammar.js",
    "build-wasm": "node scripts/build-grammar.js --only-wasm",
    "build-wasm-rust": "cd tree-sitter-cangjie && cargo build --target wasm32-wasip2 --release",
    "build-wasm-web": "cd tree-sitter-cangjie && cargo build --target wasm32-unknown-unknown --release",
    "generate": "cd tree-sitter-cangjie && npx tree-sitter generate",
    "test": "cd tree-sitter-cangjie && npx tree-sitter test",
    "test-rust": "cd tree-sitter-cangjie && cargo test",
    "clean": "rm -rf tree-sitter-cangjie/src/parser.c tree-sitter-cangjie/src/parser.h tree-sitter-cangjie/src/tree_sitter/*.h tree-sitter-cangjie.wasm"
  },
  "devDependencies": {
    "tree-sitter-cli": "^0.25.10"
  }
}
```

## 4. CI/CD 配置

### 4.1 GitHub Actions 工作流

项目使用 GitHub Actions 进行持续集成和发布。主要工作流包括：

- `ci.yml`：持续集成，运行测试和构建
- `release.yml`：发布扩展
- `update-dependencies.yml`：更新依赖

### 4.2 CI 流程详解

#### CI 工作流（ci.yml）

**触发条件**：
- 推送至 main 分支
- 拉取请求至 main 分支

**作业**：
1. **build**：构建扩展
   - 安装 Cangjie SDK
   - 设置 Node.js
   - 设置 Rust
   - 安装 WASI SDK 29
   - 安装 Wasmtime
   - 构建 Tree-sitter 语法
   - 运行测试

2. **test-bindings**：测试绑定
   - 安装依赖
   - 构建 Tree-sitter 语法（包括 WASM）
   - 运行 Rust 测试
   - 测试 WASM 模块
   - 运行 Go、Python 和 Swift 绑定测试

### 4.3 WASI 运行时支持

CI 流程中集成了 Wasmtime 作为 WASI 运行时：

**安装步骤**：
- **Linux/macOS**：使用官方安装脚本 `curl -sSf https://wasmtime.dev/install.sh | bash`
- **Windows**：下载预编译二进制包并解压

**测试步骤**：
```bash
# 验证 wasmtime 安装
wasmtime --version

# 检查 WASM 文件存在性
ls -la tree-sitter-cangjie/target/wasm32-wasip2/release/

# 验证 WASM 模块
wasmtime validate tree-sitter-cangjie/target/wasm32-wasip2/release/tree_sitter_cangjie.wasm
```

## 5. 构建和测试

### 5.1 构建命令

#### 构建完整扩展
```bash
npm run build
```

#### 构建 Tree-sitter 语法（包括 WASM）
```bash
npm run build-grammar
```

#### 仅构建 WASM 模块
```bash
npm run build-wasm
```

#### 构建特定目标的 WASM
```bash
# 构建 WASI WASM
npm run build-wasm-rust

# 构建 Web WASM
npm run build-wasm-web
```

### 5.2 测试命令

#### 运行 Tree-sitter 测试
```bash
npm run test
```

#### 运行 Rust 测试
```bash
npm run test-rust
```

#### 清理生成的文件
```bash
npm run clean
```

## 6. WASM 支持配置

### 6.1 Tree-sitter WASM 构建

项目使用 Rust 构建 Tree-sitter 语法的 WASM 模块，支持两种目标：

1. **WASI WASM**（用于服务器端）：
   - 目标：`wasm32-wasip2`
   - 输出路径：`tree-sitter-cangjie/target/wasm32-wasip2/release/tree_sitter_cangjie.wasm`

2. **Web WASM**（用于浏览器）：
   - 目标：`wasm32-unknown-unknown`
   - 输出路径：`tree-sitter-cangjie/target/wasm32-unknown-unknown/release/tree_sitter_cangjie.wasm`

### 6.2 build-grammar.js 脚本

`scripts/build-grammar.js` 是核心构建脚本，支持以下功能：

- 生成 Tree-sitter 解析器
- 构建 Tree-sitter 解析器
- 构建两种 WASM 目标
- 支持 `--only-wasm` 选项，跳过 Tree-sitter 生成和构建步骤

#### 使用示例

**完整构建**：
```bash
node scripts/build-grammar.js
```

**仅构建 WASM**：
```bash
node scripts/build-grammar.js --only-wasm
```

## 7. 扩展配置选项

### 7.1 SDK 配置

扩展需要知道 Cangjie SDK 的位置：

**自动检测**：
- Windows：`C:\Program Files\Cangjie`，`D:\Program Files\Cangjie`
- macOS/Linux：`/usr/local/cangjie`，`/opt/cangjie`

**手动配置**：
在项目的 `settings.json` 中添加：

```json
{
  "cangjie": {
    "sdkPath": "/absolute/path/to/your/cangjie-sdk-directory"
  }
}
```

### 7.2 工具覆盖

可以自定义工具路径：

```json
{
  "cangjie": {
    "sdkPath": "/path/to/sdk",
    "lspPathOverride": "/custom/path/to/my/LSPServer",
    "cjpmPathOverride": "/custom/path/to/my/cjpm"
  }
}
```

## 8. 开发流程

### 8.1 贡献步骤

1. 克隆仓库
2. 安装依赖
3. 创建分支
4. 开发功能
5. 运行测试
6. 提交更改
7. 创建拉取请求

### 8.2 代码风格

- 使用 Prettier 格式化 JavaScript/TypeScript 代码
- 使用 Rustfmt 格式化 Rust 代码
- 遵循项目的提交规范

## 9. 故障排除

### 9.1 WASM 构建失败

**问题**：`fatal error: 'stdbool.h' file not found`

**解决方案**：确保安装了 WASI SDK 并正确设置了 `WASI_SDK_PATH` 环境变量：

```bash
export WASI_SDK_PATH=/opt/wasi-sdk-29.0
```

### 9.2 Tree-sitter 生成失败

**问题**：`command not found: tree-sitter`

**解决方案**：确保 Tree-sitter CLI 已安装：

```bash
npm install -g tree-sitter-cli
```

### 9.3 Rust 测试失败

**问题**：依赖问题或代码错误

**解决方案**：
1. 更新依赖：`cargo update`
2. 检查代码错误：`cargo check`
3. 运行单个测试：`cargo test <test-name>`

## 10. 相关资源

- [Cangjie 官方网站](https://cangjie-lang.cn/)
- [Zed 编辑器](https://zed.dev/)
- [Tree-sitter 文档](https://tree-sitter.github.io/tree-sitter/)
- [Rust WASM 文档](https://rustwasm.github.io/docs/book/)
- [Wasmtime 文档](https://docs.wasmtime.dev/)

## 11. 脚本使用指南

### 11.1 构建脚本

#### build-grammar.js

核心构建脚本，用于构建Tree-sitter语法和WASM模块。

**功能**：
- 生成Tree-sitter解析器
- 构建Tree-sitter解析器
- 构建两种WASM目标：WASI WASM和Web WASM
- 将WASI WASM复制到主目录

**用法**：
```bash
# 完整构建（生成+构建+WASM）
node scripts/build-grammar.js

# 仅构建WASM（跳过生成和构建步骤）
node scripts/build-grammar.js --only-wasm
```

### 11.2 PowerShell脚本

#### bump-version.ps1

用于更新项目版本号和创建git标签。

**功能**：
- 更新package.json和extension.toml中的版本号
- 创建git标签
- 支持语义化版本（major, minor, patch）

**参数**：
- `-Type`：版本更新类型（major, minor, patch），默认patch
- `-Version`：指定确切版本号，忽略Type参数
- `-Preview`：预览模式，不实际修改文件
- `-Files`：额外需要更新版本号的文件

**用法**：
```powershell
# 增加patch版本
.ump-version.ps1 -Type patch

# 增加minor版本
.ump-version.ps1 -Type minor

# 指定确切版本号
.ump-version.ps1 -Version "1.2.3"

# 预览模式
.ump-version.ps1 -Type major -Preview
```

#### generate-changelog.ps1

从git提交历史生成CHANGELOG.md文件。

**功能**：
- 使用约定式提交消息分类更改
- 支持语义化版本
- 生成结构化的CHANGELOG.md

**参数**：
- `-OutputFile`：输出文件路径，默认CHANGELOG.md
- `-Version`：当前版本号

**用法**：
```powershell
# 生成CHANGELOG.md
.\generate-changelog.ps1 -Version "1.0.0"

# 输出到指定文件
.\generate-changelog.ps1 -OutputFile "docs/CHANGELOG.md" -Version "1.0.0"
```

#### tree-sitter-tools.ps1

Tree-sitter相关的工具脚本，提供多种操作。

**功能**：
- 构建Tree-sitter解析器
- 运行Tree-sitter测试
- 从外部仓库复制测试文件
- 清理生成的文件
- 更新语法文件
- 检查依赖
- 克隆外部测试仓库

**参数**：
- `-Action`：要执行的操作
- `-SourceDir`：测试文件源目录
- `-TargetDirs`：测试文件目标目录
- `-Count`：要复制的测试文件数量
- `-RepoUrl`：测试仓库的Git URL
- `-Branch`：测试仓库的分支

**可用操作**：
- `build`：构建Tree-sitter解析器
- `test`：运行Tree-sitter测试
- `copy-tests`：从外部仓库复制测试文件
- `clean`：清理生成的文件
- `update-grammar`：更新语法文件
- `check-deps`：检查依赖
- `clone-tests`：克隆外部测试仓库
- `help`：显示帮助信息

**用法**：
```powershell
# 构建Tree-sitter解析器
.	ree-sitter-tools.ps1 -Action build

# 运行Tree-sitter测试
.	ree-sitter-tools.ps1 -Action test

# 从外部仓库复制100个测试文件
.	ree-sitter-tools.ps1 -Action copy-tests -Count 100

# 清理生成的文件
.	ree-sitter-tools.ps1 -Action clean
```

#### update-dependencies.ps1

更新项目依赖并验证工具链配置。

**功能**：
- 更新npm依赖
- 更新Rust依赖
- 更新tree-sitter-cli到指定版本
- 验证工具链配置
- 运行测试

**参数**：
- `-DryRun`：干运行模式，不实际更新依赖
- `-SkipTests`：跳过更新后的测试
- `-Help`：显示帮助信息
- `-ValidateOnly`：仅验证工具链配置，不更新

**用法**：
```powershell
# 更新所有依赖并运行测试
.\update-dependencies.ps1

# 干运行模式
.\update-dependencies.ps1 -DryRun

# 更新依赖但跳过测试
.\update-dependencies.ps1 -SkipTests

# 仅验证工具链配置
.\update-dependencies.ps1 -ValidateOnly
```

## 12. 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE) 文件。

---

**文档版本**：1.0.0
**最后更新**：2025-11-28