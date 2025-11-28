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
- WASI SDK 29.0+（用于编译 WASM 模块，支持 x86_64 和 arm64 架构）
- Cangjie SDK 1.0.4+（用于开发和测试，支持 x86_64 和 arm64 架构）
- PowerShell 7.0+（用于运行项目提供的 PowerShell 脚本，支持 x86_64 和 arm64 架构）

### 2.1.1 架构支持
项目全面支持以下架构：
- **x86_64**（64位 Intel/AMD）
- **arm64**（64位 ARM，如 Apple Silicon、Windows on ARM）

所有构建脚本、SDK 安装脚本和验证脚本都已优化，可自动检测系统架构并使用相应的配置。

### 2.2 依赖安装

### 2.3 PowerShell 7 配置

项目中的 PowerShell 脚本都需要 PowerShell 7.0+ 才能运行。以下是安装和配置 PowerShell 7 的方法：

#### 方法一：使用安装脚本（推荐）

项目提供了一个 PowerShell 脚本，可以帮助您配置 PowerShell 7：

**Windows**：
```powershell
# 运行 PowerShell 7 配置脚本
.\update-ps1-scripts.ps1
```

**脚本功能**：
- 检查所有 PowerShell 脚本是否包含 `#Requires -Version 7.0` 指令
- 为缺少指令的脚本添加 `#Requires -Version 7.0` 指令
- 确保所有脚本只能在 PowerShell 7 中运行

#### 方法二：手动安装和配置

**安装 PowerShell 7**：
- 从 [Microsoft 官方网站](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) 下载并安装 PowerShell 7
- 或使用 Winget 安装：`winget install --id Microsoft.PowerShell`

**配置 PowerShell 7**：

1. **使用 pwsh 命令**：
   ```powershell
   # 使用 pwsh 命令而不是 powershell 命令
   pwsh -ExecutionPolicy Bypass -File .\tree-sitter-tools.ps1 -Action help
   ```

2. **使用批处理包装器**：
   项目提供了 `run-ps-script.bat` 批处理文件，确保使用 PowerShell 7：
   ```powershell
   .\run-ps-script.bat .\tree-sitter-tools.ps1 -Action help
   ```

3. **设置 PowerShell 配置文件**：
   将以下内容添加到您的 PowerShell 配置文件（`$PROFILE`）中：
   ```powershell
   # Alias powershell to pwsh to ensure PowerShell 7 is used
   alias powershell='pwsh'
   ```

#### 验证 PowerShell 7 配置

要验证 PowerShell 7 是否正在使用：

```powershell
$PSVersionTable
```

预期输出：
```
Name                           Value
----                           -----
PSVersion                      7.5.4
PSEdition                      Core
GitCommitId                    7.5.4
```

#### 故障排除

1. **错误："无法运行脚本，因为该脚本包含用于 Windows PowerShell 7.0 的 '#requires' 语句"**
   - 这意味着您正在尝试使用 PowerShell 5.1 运行 PowerShell 7 脚本
   - 解决方案：使用 `pwsh` 命令而不是 `powershell` 命令

2. **错误："pwsh: The term 'pwsh' is not recognized"**
   - 这意味着 PowerShell 7 没有安装
   - 解决方案：从 Microsoft 官方网站下载并安装 PowerShell 7

### 2.4 依赖安装

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

#### 安装 WASI SDK

**Linux/macOS**：

```bash
# 自动检测架构
ARCH=$(uname -m)

# 根据架构选择正确的 WASI SDK 下载 URL
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    WASI_SDK_URL="https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-29/wasi-sdk-29.0-aarch64-linux.tar.gz"
else
    WASI_SDK_URL="https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-29/wasi-sdk-29.0-x86_64-linux.tar.gz"
fi

# 下载并安装 WASI SDK 29.0
curl -sSfL $WASI_SDK_URL | tar -xzf - -C /opt

# 设置 WASI_SDK_PATH 环境变量
export WASI_SDK_PATH=/opt/wasi-sdk-29.0

# 将环境变量添加到 shell 配置文件（可选，以便永久生效）
echo "export WASI_SDK_PATH=/opt/wasi-sdk-29.0" >> ~/.bashrc  # 或 ~/.zshrc
```

**macOS (Apple Silicon)**：

```bash
# 下载并安装 WASI SDK 29.0 for arm64
curl -sSfL https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-29/wasi-sdk-29.0-aarch64-macos.tar.gz | tar -xzf - -C /opt

# 设置 WASI_SDK_PATH 环境变量
export WASI_SDK_PATH=/opt/wasi-sdk-29.0

# 将环境变量添加到 shell 配置文件（可选，以便永久生效）
echo "export WASI_SDK_PATH=/opt/wasi-sdk-29.0" >> ~/.zshrc
```

**Windows**（PowerShell）：

##### 方法一：使用安装脚本（推荐）
如果您已经下载并解压了 WASI SDK，可以使用项目提供的 PowerShell 脚本快速配置环境变量：

```powershell
# 运行 WASI SDK 配置脚本
.\setup-wasi-sdk.ps1 -WasiSdkPath "D:\Downloads\wasi-sdk-29.0-x86_64-windows\wasi-sdk-29.0-x86_64-windows"    
```

##### 方法二：手动配置
```powershell
# 下载 WASI SDK 29.0
$wasiSdkUrl = "https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-29/wasi-sdk-29.0-mingw.tar.gz"
$tempDir = Join-Path -Path $env:TEMP -ChildPath "wasi-sdk"
New-Item -Path $tempDir -ItemType Directory -Force | Out-Null
$wasiSdkFile = Join-Path -Path $tempDir -ChildPath "wasi-sdk.tar.gz"
Invoke-WebRequest -Uri $wasiSdkUrl -OutFile $wasiSdkFile -UseBasicParsing

# 解压 WASI SDK（需要 Git Bash 或其他支持 tar 的工具）
bash -c "tar -xzf $wasiSdkFile -C $tempDir"

# 获取 WASI SDK 目录路径
$wasiSdkDir = Get-ChildItem -Path $tempDir -Name "wasi-sdk-*" | Select-Object -First 1
$wasiSdkPath = Join-Path -Path $tempDir -ChildPath $wasiSdkDir

# 设置 WASI_SDK_PATH 环境变量
[Environment]::SetEnvironmentVariable("WASI_SDK_PATH", $wasiSdkPath, "User")

# 立即生效环境变量
$env:WASI_SDK_PATH = $wasiSdkPath
```

#### 安装 Cangjie SDK

##### 方法一：使用安装脚本（推荐）

项目提供了一个 PowerShell 脚本，可以自动下载、安装和配置 Cangjie SDK，支持 x86_64 和 arm64 架构：

**Windows**：
```powershell
# 运行 Cangjie SDK 安装脚本
.\setup-cangjie-sdk.ps1

# 或指定版本和安装路径
.\setup-cangjie-sdk.ps1 -SdkVersion 1.0.4 -InstallPath "D:\Program Files\Cangjie"
```

**脚本功能**：
- 自动检测系统架构（x86_64 或 arm64）
- 自动下载指定版本和架构的 Cangjie SDK
- 安装到指定目录
- 配置环境变量（`CANGJIE_HOME` 和 `PATH`）
- 验证安装是否成功
- 清理临时文件
- 支持 x86_64 和 arm64 架构

**架构支持**：
- 脚本会自动检测系统架构，并尝试下载对应架构的 Cangjie SDK
- 如果架构特定的 SDK 不可用，会自动回退到通用版本
- 支持 Windows x86_64、Windows arm64、Linux x86_64、Linux arm64 和 macOS arm64（Apple Silicon）

##### 方法二：手动安装

**Linux/macOS**：
```bash
curl -sSf https://cangjie-lang.cn/download/1.0.4 | sudo tar -xzf - -C /usr/local
```

**Windows**：
```powershell
Invoke-WebRequest -Uri https://cangjie-lang.cn/download/1.0.4 -OutFile cangjie-sdk.zip
Expand-Archive -Path cangjie-sdk.zip -DestinationPath "C:\Program Files\Cangjie" -Force

# 手动设置环境变量
[Environment]::SetEnvironmentVariable("CANGJIE_HOME", "C:\Program Files\Cangjie", "User")
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
[Environment]::SetEnvironmentVariable("PATH", "$currentPath;C:\Program Files\Cangjie\bin", "User")
$env:CANGJIE_HOME = "C:\Program Files\Cangjie"
$env:PATH += ";C:\Program Files\Cangjie\bin"
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
   - 设置 Node.js
   - 设置 Rust
   - 安装 WASI SDK 29
   - 安装 Wasmtime
   - 构建 Tree-sitter 语法
   - 运行测试
   - 安装 Cangjie SDK（可选）

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
   - 依赖：需要 WASI SDK 提供的编译器和系统头文件

2. **Web WASM**（用于浏览器）：
   - 目标：`wasm32-unknown-unknown`
   - 输出路径：`tree-sitter-cangjie/target/wasm32-unknown-unknown/release/tree_sitter_cangjie.wasm`
   - 依赖：不需要 WASI SDK，使用 Rust 自带的 WebAssembly 支持

### 6.2 WASI SDK 配置

项目的 `build.rs` 文件已经配置为自动使用 WASI SDK 来编译 C 代码：

1. **自动检测**：从环境变量 `WASI_SDK_PATH` 获取 WASI SDK 路径
2. **默认路径**：如果未设置环境变量，将使用默认路径：
   - Linux/macOS：`/opt/wasi-sdk-29.0`
   - Windows：`C:/opt/wasi-sdk-29.0`
3. **编译器配置**：使用 WASI SDK 的 clang 编译器来编译 C 代码
4. **包含路径**：添加 WASI SDK 的系统头文件路径
5. **目标设置**：明确指定目标为 `wasm32-wasip2`
6. **WASI 特定标志**：
   - `-nostdlib`：禁用标准库（使用 WASI 提供的库）
   - `-fvisibility=hidden`：隐藏非导出符号，减小二进制大小
   - `-fPIC`：生成位置无关代码，这是 WASM 所必需的

### 6.3 build-grammar.js 脚本

`scripts/build-grammar.js` 是核心构建脚本，支持以下功能：

- 生成 Tree-sitter 解析器
- 构建 Tree-sitter 解析器
- 构建两种 WASM 目标：
  - WASI WASM：`cargo build --target wasm32-wasip2 --release`
  - Web WASM：`cargo build --target wasm32-unknown-unknown --release`
- 将 WASI WASM 复制到主目录
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

### 6.4 验证 WASM 模块

构建完成后，可以使用项目提供的 `test-wasm-module.ps1` 脚本或手动使用 Wasmtime 来验证 WASM 模块：

#### 方法一：使用 test-wasm-module.ps1 脚本（推荐）

项目提供了一个功能全面的 PowerShell 脚本，可以自动验证 WASM 模块：

```powershell
# 基本验证（检查 wasmtime 安装、WASM 文件存在性、验证模块）
.	est-wasm-module.ps1

# 自动安装 wasmtime 并验证
.	est-wasm-module.ps1 -InstallWasmtime

# 验证并运行模块
.	est-wasm-module.ps1 -RunModule

# 验证不同目标的 WASM 模块
.	est-wasm-module.ps1 -WasmTarget wasm32-unknown-unknown
```

#### 方法二：手动验证

如果您更喜欢手动验证，可以使用以下命令：

```bash
# 验证 wasmtime 安装
wasmtime --version

# 检查 WASM 文件存在性
ls -la tree-sitter-cangjie/target/wasm32-wasip2/release/

# 验证 WASM 模块
wasmtime validate tree-sitter-cangjie/target/wasm32-wasip2/release/tree_sitter_cangjie.wasm
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

#### 问题 1：`fatal error: 'stdbool.h' file not found`

**解决方案**：确保安装了 WASI SDK 并正确设置了 `WASI_SDK_PATH` 环境变量：

**Linux/macOS**：
```bash
export WASI_SDK_PATH=/opt/wasi-sdk-29.0
```

**Windows**（PowerShell）：
```powershell
$env:WASI_SDK_PATH = "C:/opt/wasi-sdk-29.0"  # 替换为实际路径
```

#### 问题 2：`clang: command not found`

**解决方案**：确保 WASI SDK 已正确安装，且 `WASI_SDK_PATH` 环境变量指向正确的目录。

#### 问题 3：`error: linker `rust-lld` not found`

**解决方案**：确保 Rust 已安装并更新到最新版本：
```bash
rustup update
```

#### 问题 4：`error: failed to run custom build command for `tree-sitter-cangjie v0.1.2``

**解决方案**：检查构建日志中的详细错误信息，通常是由于 C 代码编译失败导致的。确保：
1. WASI SDK 已正确安装
2. `WASI_SDK_PATH` 环境变量已正确设置
3. C 代码没有语法错误
4. Tree-sitter 解析器已正确生成

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

### 9.4 WASM 模块验证失败

**问题**：`wasmtime validate: error: invalid module`

**解决方案**：
1. 确保 WASM 模块是使用正确的目标构建的：`wasm32-wasip2`
2. 检查构建日志中的错误信息
3. 确保 WASI SDK 版本与项目要求的版本一致（29.0+）

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

#### setup-cangjie-sdk.ps1

用于自动下载、安装和配置Cangjie SDK。

**功能**：
- 自动下载指定版本的Cangjie SDK
- 安装到指定目录
- 配置环境变量（`CANGJIE_HOME` 和 `PATH`）
- 验证安装是否成功
- 清理临时文件

**参数**：
- `-SdkVersion`：指定要安装的Cangjie SDK版本，默认1.0.4
- `-InstallPath`：指定安装路径，默认`C:\Program Files\Cangjie`
- `-Force`：强制重新安装，覆盖现有安装
- `-Silent`：静默安装，不显示详细输出

**用法**：
```powershell
# 安装默认版本到默认路径
.\setup-cangjie-sdk.ps1

# 安装指定版本到自定义路径
.\setup-cangjie-sdk.ps1 -SdkVersion 1.0.4 -InstallPath "D:\Program Files\Cangjie"

# 强制重新安装
.\setup-cangjie-sdk.ps1 -Force
```

#### setup-wasi-sdk.ps1

用于配置WASI SDK环境变量，支持x86_64和arm64架构。

**功能**：
- 自动检测系统架构（x86_64或arm64）
- 设置 `WASI_SDK_PATH` 环境变量
- 支持用户级和系统级环境变量
- 验证环境变量设置是否成功
- 根据架构和操作系统调整预期的WASI SDK文件结构

**参数**：
- `-WasiSdkPath`：WASI SDK的安装路径
- `-Scope`：环境变量作用域（User或Machine），默认User
- `-Silent`：静默模式，不显示详细输出

**用法**：
```powershell
# 配置WASI SDK环境变量
.\setup-wasi-sdk.ps1 -WasiSdkPath "D:\Downloads\wasi-sdk-29.0-x86_64-windows\wasi-sdk-29.0-x86_64-windows"

# 配置系统级环境变量
.\setup-wasi-sdk.ps1 -WasiSdkPath "C:\opt\wasi-sdk-29.0" -Scope Machine
```

**架构支持**：
- 脚本会自动检测系统架构
- 对于Windows系统，验证WASI SDK目录时检查 `bin/clang.exe`
- 对于非Windows系统，验证WASI SDK目录时检查 `bin/clang`
- 支持x86_64和arm64架构的WASI SDK安装

#### test-wasm-module.ps1

用于验证WASM模块，包括wasmtime安装、WASM文件检查和模块验证。

**功能**：
- 检查wasmtime安装情况，支持自动安装
- 验证WASM文件存在性
- 列出WASM文件所在目录内容
- 验证WASM模块结构
- 可选：运行WASM模块
- 支持多种WASM目标

**参数**：
- `-InstallWasmtime`：自动安装wasmtime，无需交互提示
- `-RunModule`：验证后运行WASM模块
- `-WasmTarget`：指定WASM目标（如wasm32-wasip2），默认wasm32-wasip2
- `-WasmFilePath`：指定自定义WASM文件路径
- `-WasmtimeVersion`：指定要安装的wasmtime版本，默认latest

**用法**：
```powershell
# 基本验证
.	est-wasm-module.ps1

# 自动安装wasmtime并验证
.	est-wasm-module.ps1 -InstallWasmtime

# 验证并运行模块
.	est-wasm-module.ps1 -RunModule

# 验证不同目标的WASM模块
.	est-wasm-module.ps1 -WasmTarget wasm32-unknown-unknown

# 验证自定义WASM文件
.	est-wasm-module.ps1 -WasmFilePath "path/to/custom.wasm"
```

#### validate-project-ps1.ps1

用于验证项目中的PowerShell脚本，确保它们符合要求。

**功能**：
- 检查所有PowerShell脚本是否包含 `#Requires -Version 7.0` 指令
- 验证脚本语法正确性
- 支持排除特定文件或目录
- 生成验证报告

**参数**：
- `-ExcludePaths`：要排除的文件或目录列表
- `-ReportPath`：生成验证报告的路径
- `-Silent`：静默模式，仅显示错误

**用法**：
```powershell
# 验证所有PowerShell脚本
.\validate-project-ps1.ps1

# 排除node_modules目录
.\validate-project-ps1.ps1 -ExcludePaths "node_modules"

# 生成验证报告
.\validate-project-ps1.ps1 -ReportPath "validation-report.txt"
```

#### update-ps1-scripts.ps1

用于确保所有PowerShell脚本都包含PowerShell 7版本要求。

**功能**：
- 检查所有PowerShell脚本是否包含 `#Requires -Version 7.0` 指令
- 为缺少指令的脚本添加 `#Requires -Version 7.0` 指令
- 支持排除特定文件
- 生成更新报告

**参数**：
- `-Exclude`：要排除的文件列表
- `-DryRun`：预览模式，不实际修改文件
- `-Report`：生成更新报告

**用法**：
```powershell
# 更新所有PowerShell脚本
.\update-ps1-scripts.ps1

# 预览更新，不实际修改文件
.\update-ps1-scripts.ps1 -DryRun

# 排除特定文件
.\update-ps1-scripts.ps1 -Exclude "test.ps1,example.ps1"
```

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

**文档版本**：1.1.0
**最后更新**：2025-11-28