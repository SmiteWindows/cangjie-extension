# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1.0 (2025-11-29)

### Added

- Initial commit of tree-sitter-cangjie grammar
- GitHub Actions workflows for CI/CD
- Support for multiple language bindings (Node.js, Rust, Python, Go, Swift)
- WebAssembly support with multiple targets
- Comprehensive testing framework
- Detailed documentation

### Changed

- Updated configuration files for standalone repository
- Improved build scripts for cross-platform compatibility
- Enhanced wasm-pack detection and installation
- Optimized GitHub workflow files for subproject use

### Fixed

- Module system conflict between ES modules and CommonJS
- Path handling issues on Windows
- wasm-pack detection on Windows systems
- JSON parsing errors in package.json

### Removed

- Dependencies on main project structure
- Redundant build code
- Unnecessary configuration files
