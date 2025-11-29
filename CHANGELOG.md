# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.0 (2025-11-28)

### Features

- 添加项目PS1文件验证脚本
- 添加多个测试用例并扩展多语言绑定支持
- 添加 PowerShell 7 支持并重构构建流程
- 实现多行原始字符串和缩进处理的外部扫描器
- 添加完整的Cangjie语言支持扩展功能
- 添加tree-sitter-cangjie查询文件和README
- 添加检查SDK是否已安装的功能
- 添加WASM模块测试脚本
- 添加 WASI SDK 支持并更新文档
- 添加LSP支持和扩展功能
- 更新WASI SDK至29.0并添加Wasmtime支持
- 更新工具链和构建配置
- 更新Cangjie图标设计并添加配置选项
- 更新工具链配置并添加多语言绑定测试
- 添加后闭括号表达式支持并优化一元表达式解析

### Fixes

- 修复tree-sitter-cangjie绑定中的命名错误
- 修复lib.rs中的问题和警告
- 修正边缘情形
- 更新CI工作流以使用PowerShell并修复命令

### Documentation

- 更新配置文档并添加PowerShell脚本说明

### Build

- 更新构建依赖 cc 到 1.2 版本
- 将C标准从C11升级到C17
- 更新 tree-sitter 依赖版本至 0.25.0 并移除 type 字段
- 更新工具链和构建配置

### CI/CD

- 移除工作流文件中的多余空行
- 更新工作流配置和版本要求
- 添加自动更新依赖的GitHub工作流和脚本
- 移除 PowerShell 7 的安装步骤
- 更新生成变更日志的脚本路径
- 更新仓库URL为GitHub镜像地址
- 更新CI配置和结果URL
- 添加 GitHub Actions CI 工作流并更新测试版本
- 使用项目脚本简化CI流程
- 将Cangjie SDK安装步骤改为可选
- 添加 Windows 平台的 WASI SDK 安装步骤
- 重构WASM构建流程使用Rust替代emcc/docker
- 添加 Emscripten 配置步骤
- 改进Cangjie SDK安装脚本的错误处理
- 添加 Cangjie SDK 安装步骤到 CI 流程
- 移除tree-sitter-cangjie的工作流配置
- 将npm发布步骤替换为清理构建产物
- 移除工作流文件中的多余空行和powershell设置

### Chore

- 移除子模块跟踪并添加到.gitignore
- 添加 cangjie 子模块
- 添加 Rust 测试脚本到 package.json