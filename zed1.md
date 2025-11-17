

zed_cangjie_extension/
├── Cargo.toml                 # Rust项目配置文件
├── build.rs                   # 构建脚本
├── src/                       # 源代码目录
│   └── lib.rs                 # 主扩展实现
├── tree-sitter-cangjie/       # Tree-sitter解析器源码
│   ├── grammar.js             # 语法定义
│   ├── src/                   # C源码
│   │   ├── parser.c           # 解析器实现
│   │   └── scanner.c          # 词法分析器（如果需要）
│   └── binding.gyp            # 构建配置（如果需要）
├── scripts/                   # 构建和工具脚本
│   └── build-grammar.js       # 构建语法解析器脚本
├── extension.json             # Zed扩展配置
├── README.md                  # 项目说明文档
├── build.sh                   # 构建脚本（Linux/macOS）
├── build.bat                  # 构建脚本（Windows）
├── tree-sitter-cangjie.wasm   # 编译后的语法解析器（构建后生成）
├── .gitignore                 # Git忽略文件配置
├── LICENSE                    # 许可证文件
├── docs/                      # 文档目录
│   ├── getting-started.md     # 快速开始指南
│   ├── features.md            # 功能特性说明
│   └── configuration.md       # 配置说明
├── assets/                    # 资源文件目录
│   └── icon.png               # 扩展图标
├── tests/                     # 测试文件目录
│   ├── fixtures/              # 测试用例文件
│   │   ├── hello.cj           # 示例Cangjie文件
│   │   ├── syntax_test.cj     # 语法测试文件
│   │   └── complex_example.cj # 复杂示例文件
│   └── integration_test.rs    # 集成测试
├── examples/                  # 示例代码目录
│   ├── basic.cj               # 基础示例
│   ├── functions.cj           # 函数示例
│   ├── structs.cj             # 结构体示例
│   ├── enums.cj               # 枚举示例
│   └── interfaces.cj          # 接口示例
├── target/                    # 编译输出目录（Git忽略）
│   ├── debug/                 # 调试版本输出
│   └── release/               # 发布版本输出
├── downloads/                 # 下载文件目录（Git忽略）
│   └── cangjie-lsp-*          # 语言服务器二进制文件
├── .zed/                      # Zed配置目录
│   └── settings.json          # Zed特定设置
├── CHANGELOG.md               # 版本变更日志
├── CONTRIBUTING.md            # 贡献指南
└── package.json               # Node.js包配置（如果需要）





[package]
name = "cangjie-extension"
version = "0.1.0"
edition = "2021"
license = "MIT"
rust-version = "1.91.0"
[lib]
crate-type = ["cdylib"]

[dependencies]
zed_extension_api = "0.7.0"

[build-dependencies]
cc = "1.2"
rust
// src/lib.rs
use zed_extension_api::{self as zed, LanguageServerId, Result};
use std::env;
use std::path::{Path, PathBuf};

struct CangjieExtension {
cached_binary_path: Option<String>,
}

impl CangjieExtension {
fn language_server_binary_path(
&mut self,
language_server_id: &LanguageServerId,
worktree: &zed::Worktree,
) -> Result<String> {
if let Some(path) = &self.cached_binary_path {
return Ok(path.clone());
}

zed::set_language_server_installation_status(
&language_server_id,
&zed::LanguageServerInstallationStatus::CheckingForUpdate,
);

let binary_name = "cangjie-lsp";

// 尝试从工作区查找语言服务器
let binary_path = worktree
.which(binary_name)
.or_else( {
// 如果工作区没有，尝试从扩展目录查找
let mut path = worktree.root_path().to_path_buf();
path.push(".zed");
path.push("extensions");
path.push("cangjie");
path.push(binary_name);

if path.exists() {
Some(path)
} else {
None
}
})
.or_else( {
// 从GitHub下载
let version = "v0.1.0";
let platform = match (env::consts::OS, env::consts::ARCH) {
("linux", "x86_64") => "x86_64-unknown-linux-gnu",
("linux", "aarch64") => "aarch64-unknown-linux-gnu",
("macos", "x86_64") => "x86_64-apple-darwin",
("macos", "aarch64") => "aarch64-apple-darwin",
("windows", "x86_64") => "x86_64-pc-windows-msvc",
_ => panic!("Unsupported platform: {}-{}", env::consts::OS, env::consts::ARCH),
};

let mut binary_path = worktree.root_path().to_path_buf();
binary_path.push(".zed");
binary_path.push("extensions");
binary_path.push("cangjie");
binary_path.push(&format!("cangjie-lsp-{}", version));
binary_path.push(binary_name);

if !binary_path.exists() {
// 创建目录
if let Some(parent) = binary_path.parent() {
std::fs::create_dir_all(parent).ok()?;
}

let url = format!(
"https://github.com/cangjie-lang/cangjie-lsp/releases/download/{}/cangjie-lsp-{}",
version,
match env::consts::OS {
"windows" => format!("{}.zip", platform),
_ => format!("{}.tar.gz", platform),
}
);

let file_type = if env::consts::OS == "windows" {
zed::DownloadedFileType::Zip
} else {
zed::DownloadedFileType::GzipTar
};

zed::download_file(&url, &binary_path, file_type)
.map_err( e format!("Failed to download {}: {}", binary_name, e))
.ok()?;
}

if cfg!(unix) {
zed::make_file_executable(&binary_path).ok()?;
}

Some(binary_path)
})
.ok_or_else( format!("No {} binary found", binary_name))?;

self.cached_binary_path = Some(binary_path.to_string_lossy().to_string());
Ok(binary_path.to_string_lossy().to_string())
}
}

impl zed::Extension for CangjieExtension {
fn new() -> Self {
Self {
cached_binary_path: None,
}
}

fn language_server_command(
&mut self,
language_server_id: &LanguageServerId,
worktree: &zed::Worktree,
) -> Result<zed::Command> {
let path = self.language_server_binary_path(language_server_id, worktree)?;
Ok(zed::Command {
command: path,
args: vec!["--stdio".to_string()],
env: Default::default(),
})
}

fn language_server_initialization_options(
&mut self,
_language_server_id: &LanguageServerId,
_worktree: &zed::Worktree,
) -> Result<Option<serde_json::Value>> {
Ok(Some(serde_json::json!({
"provideFormatter": true,
"enableSemanticHighlighting": true
})))
}

fn language_server_workspace_configuration(
&mut self,
_language_server_id: &LanguageServerId,
_worktree: &zed::Worktree,
) -> Result<Option<serde_json::Value>> {
Ok(Some(serde_json::json!({
"cangjie": {
"enableSemanticHighlighting": true,
"maxFileSize": 1000000,
"checkOnSave": true
}
})))
}

fn lsp_adapters(&self) -> Vec<Box<dyn zed::LspAdapter>> {
vec![Box::new(CangjieLspAdapter)]
}

fn language_name(&self) -> &'static str {
"Cangjie"
}

fn file_extensions(&self) -> &'static [&'static str] {
&["cj", "cangjie"]
}

fn line_comments(&self) -> &'static [&'static str] {
&["// "]
}

fn block_comment(&self) -> Option<(&'static str, &'static str)> {
Some(("/", "/"))
}

fn brackets(&self) -> &'static [zed::BracketPair] {
&[
zed::BracketPair {
start: "{",
end: "}",
close: true,
newline: true,
},
zed::BracketPair {
start: "[",
end: "]",
close: true,
newline: false,
},
zed::BracketPair {
start: "(",
end: ")",
close: true,
newline: false,
},
]
}

fn indentation_based_folding_supported(&self) -> bool {
true
}

fn tab_size_for_language(&self, _language_name: &str) -> Option<u32> {
Some(4)
}

fn hard_tabs_only(&self) -> bool {
false
}

fn highlight_text(
&self,
text: &mut zed::Text,
language_name: &str,
) -> Vec<zed::Highlight> {
// 这里会使用tree-sitter语法高亮
vec![]
}

fn symbol_contexts(&self, _text: &zed::Text, _location: usize) -> Option<zed::SymbolContext> {
None
}

fn symbols(&self, _text: &zed::Text) -> Vec<zed::Symbol> {
vec![]
}

fn code_actions(
&self,
_file: &zed::File,
_line: &str,
_language_server_id: &LanguageServerId,
) -> Result<Vec<zed::CodeAction>> {
Ok(vec![])
}

fn on_type_formatting_rules(
&self,
_language_name: &str,
) -> Option<zed::OnTypeFormattingRules> {
Some(zed::OnTypeFormattingRules {
format_on_save: true,
format_on_type: true,
})
}

fn task_templates(&self) -> Option<Vec<zed::TaskTemplate>> {
Some(vec![
zed::TaskTemplate {
label: "Run Cangjie Program".to_string(),
command: "cangjie".to_string(),
args: vec!["run".to_string(), "${file}".to_string()],
..Default::default()
},
zed::TaskTemplate {
label: "Build Cangjie Project".to_string(),
command: "cangjie".to_string(),
args: vec!["build".to_string(), "${file}".to_string()],
..Default::default()
},
])
}
}

struct CangjieLspAdapter;

impl zed::LspAdapter for CangjieLspAdapter {
fn name(&self) -> &'static str {
"Cangjie LSP"
}

fn language_server_command(
&mut self,
language_server_id: &LanguageServerId,
worktree: &zed::Worktree,
) -> Result<zed::Command> {
let mut extension = CangjieExtension::new();
extension.language_server_command(language_server_id, worktree)
}

fn initialization_options(
&self,
_language_server_id: &LanguageServerId,
_worktree: &zed::Worktree,
) -> Result<Option<serde_json::Value>> {
Ok(Some(serde_json::json!({
"provideFormatter": true,
"enableSemanticHighlighting": true
})))
}

fn workspace_configuration(
&self,
_language_server_id: &LanguageServerId,
_worktree: &zed::Worktree,
) -> Result<Option<serde_json::Value>> {
Ok(Some(serde_json::json!({
"cangjie": {
"enableSemanticHighlighting": true,
"maxFileSize": 1000000,
"checkOnSave": true
}
})))
}

fn language_ids(&self) -> Vec<String> {
vec!["cangjie".to_string()]
}

fn code_action_kinds(&self) -> Option<Vec<String>> {
Some(vec![
"quickfix".to_string(),
"refactor".to_string(),
"refactor.extract".to_string(),
"refactor.inline".to_string(),
"refactor.rewrite".to_string(),
"source".to_string(),
"source.organizeImports".to_string(),
])
}

fn support_rename(&self) -> bool {
true
}

fn support_format(&self) -> bool {
true
}

fn support_completion(&self) -> bool {
true
}

fn completion_triggers(&self) -> Vec<String> {
vec![".".to_string(), ":".to_string(), "\"".to_string(), "/".to_string()]
}
}

// Tree-sitter解析器相关代码
mod tree_sitter_cangjie {
use tree_sitter::Language;

extern "C" {
fn tree_sitter_cangjie() -> Language;
}

pub fn language() -> Language {
unsafe { tree_sitter_cangjie() }
}
}

// 语法高亮定义
fn cangjie_syntax_highlights() -> Vec<zed::SyntaxHighlight> {
vec![
zed::SyntaxHighlight {
name: "keyword".to_string(),
scope: "keyword".to_string(),
},
zed::SyntaxHighlight {
name: "function".to_string(),
scope: "function".to_string(),
},
zed::SyntaxHighlight {
name: "variable".to_string(),
scope: "variable".to_string(),
},
zed::SyntaxHighlight {
name: "type".to_string(),
scope: "type".to_string(),
},
zed::SyntaxHighlight {
name: "comment".to_string(),
scope: "comment".to_string(),
},
zed::SyntaxHighlight {
name: "string".to_string(),
scope: "string".to_string(),
},
zed::SyntaxHighlight {
name: "number".to_string(),
scope: "number".to_string(),
},
zed::SyntaxHighlight {
name: "operator".to_string(),
scope: "operator".to_string(),
},
zed::SyntaxHighlight {
name: "punctuation".to_string(),
scope: "punctuation".to_string(),
},
zed::SyntaxHighlight {
name: "property".to_string(),
scope: "property".to_string(),
},
zed::SyntaxHighlight {
name: "parameter".to_string(),
scope: "parameter".to_string(),
},
zed::SyntaxHighlight {
name: "macro".to_string(),
scope: "macro".to_string(),
},
zed::SyntaxHighlight {
name: "module".to_string(),
scope: "module".to_string(),
},
zed::SyntaxHighlight {
name: "interface".to_string(),
scope: "interface".to_string(),
},
zed::SyntaxHighlight {
name: "class".to_string(),
scope: "class".to_string(),
},
zed::SyntaxHighlight {
name: "enum".to_string(),
scope: "enum".to_string(),
},
zed::SyntaxHighlight {
name: "struct".to_string(),
scope: "struct".to_string(),
},
zed::SyntaxHighlight {
name: "trait".to_string(),
scope: "trait".to_string(),
},
]
}

// 扩展初始化函数
#[no_mangle]
pub extern "C" fn extension_init() -> mut dyn zed::Extension {
Box::into_raw(Box::new(CangjieExtension::new()))
}

c
// tree-sitter-cangjie/src/parser.c
// 注意：这是简化版的tree-sitter解析器框架代码
// 实际的解析器代码会更复杂，这里仅展示基本结构

#include <tree_sitter/parser.h>

enum TokenType {
COMMENT,
STRING,
NUMBER,
IDENTIFIER,
};

void tree_sitter_cangjie_external_scanner_create() { return NULL; }
void tree_sitter_cangjie_external_scanner_destroy(void p) {}
unsigned tree_sitter_cangjie_external_scanner_serialize(void p, char buffer) { return 0; }
void tree_sitter_cangjie_external_scanner_deserialize(void p, const char b, unsigned n) {}

bool tree_sitter_cangjie_external_scanner_scan(void payload, TSLexer lexer, const bool valid_symbols) {
return false;
}

const TSLanguage tree_sitter_cangjie(void) {
static const TSLanguage language = {
.version = LANGUAGE_VERSION,
.symbol_count = 0,
.alias_count = 0,
.token_count = 0,
.external_token_count = 0,
.state_count = 0,
.large_state_count = 0,
.production_id_count = 0,
.field_count = 0,
.max_alias_sequence_length = 0,
.parse_table = NULL,
.small_parse_table = NULL,
.small_parse_table_map = NULL,
.parse_actions = NULL,
.symbol_names = NULL,
.symbol_metadata = NULL,
.public_symbol_map = NULL,
.alias_map = NULL,
.alias_sequences = NULL,
.lex_modes = NULL,
.lex_fn = NULL,
.keyword_lex_fn = NULL,
.keyword_capture_token = 0,
.external_scanner = {
.symbol_map = NULL,
.serialize = tree_sitter_cangjie_external_scanner_serialize,
.deserialize = tree_sitter_cangjie_external_scanner_deserialize,
.scan = tree_sitter_cangjie_external_scanner_scan,
.create = tree_sitter_cangjie_external_scanner_create,
.destroy = tree_sitter_cangjie_external_scanner_destroy,
},
.primary_state_ids = NULL,
};
return &language;
}

// tree-sitter-cangjie/grammar.js
// Cangjie语言的Tree-sitter语法定义

module.exports = grammar({
name: 'cangjie',

extras: $ => [
/\s/,
$.comment
],

rules: {
// 程序入口
source_file: $ => repeat($._definition),

// 定义（函数、变量、类型等）
_definition: $ => choice(
$.function_definition,
$.variable_declaration,
$.struct_definition,
$.enum_definition,
$.interface_definition,
$.module_declaration,
$.import_statement
),

// 函数定义
function_definition: $ => seq(
optional('pub'),
'fn',
field('name', $.identifier),
field('parameters', $.parameter_list),
optional(seq('->', field('return_type', $._type))),
field('body', $.block)
),

// 参数列表
parameter_list: $ => seq(
'(',
commaSep($.parameter),
')'
),

parameter: $ => seq(
field('name', $.identifier),
':',
field('type', $._type)
),

// 变量声明
variable_declaration: $ => seq(
optional('pub'),
choice('let', 'var'),
field('name', $.identifier),
optional(seq(':', field('type', $._type))),
optional(seq('=', field('value', $._expression)))
),

// 结构体定义
struct_definition: $ => seq(
optional('pub'),
'struct',
field('name', $.identifier),
field('fields', $.field_list)
),

field_list: $ => seq(
'{',
commaSep($.field),
'}'
),

field: $ => seq(
optional('pub'),
field('name', $.identifier),
':',
field('type', $._type)
),

// 枚举定义
enum_definition: $ => seq(
optional('pub'),
'enum',
field('name', $.identifier),
'{',
commaSep($.enum_variant),
'}'
),

enum_variant: $ => seq(
field('name', $.identifier),
optional(seq('=', field('value', $._expression)))
),

// 接口定义
interface_definition: $ => seq(
optional('pub'),
'interface',
field('name', $.identifier),
'{',
repeat($.interface_method),
'}'
),

interface_method: $ => seq(
field('name', $.identifier),
field('parameters', $.parameter_list),
optional(seq('->', field('return_type', $._type)))
),

// 模块声明
module_declaration: $ => seq(
'module',
field('name', $.identifier)
),

// 导入语句
import_statement: $ => seq(
'import',
field('path', $.import_path)
),

import_path: $ => seq(
$.identifier,
repeat(seq('.', $.identifier))
),

// 代码块
block: $ => seq(
'{',
repeat($._statement),
'}'
),

// 语句
_statement: $ => choice(
$.expression_statement,
$.assignment_statement,
$.return_statement,
$.if_statement,
$.for_statement,
$.while_statement,
$.break_statement,
$.continue_statement
),

expression_statement: $ => seq($._expression, ';'),

assignment_statement: $ => seq(
field('left', $._expression),
'=',
field('right', $._expression),
';'
),

return_statement: $ => seq('return', optional($._expression), ';'),

if_statement: $ => seq(
'if',
field('condition', $._expression),
field('consequence', $.block),
optional(seq('else', field('alternative', $.block)))
),

for_statement: $ => seq(
'for',
field('variable', $.identifier),
'in',
field('iterable', $._expression),
field('body', $.block)
),

while_statement: $ => seq(
'while',
field('condition', $._expression),
field('body', $.block)
),

break_statement: $ => seq('break', ';'),
continue_statement: $ => seq('continue', ';'),

// 表达式
_expression: $ => choice(
$.identifier,
$.string,
$.number,
$.boolean,
$.function_call,
$.field_access,
$.array_access,
$.binary_expression,
$.unary_expression,
$.parenthesized_expression
),

function_call: $ => seq(
field('function', $._expression),
field('arguments', $.argument_list)
),

argument_list: $ => seq(
'(',
commaSep($._expression),
')'
),

field_access: $ => prec.left(seq($._expression, '.', $.identifier)),

array_access: $ => seq($._expression, '[', $._expression, ']'),

binary_expression: $ => choice(
...[
['+', 'left'],
['-', 'left'],
['', 'left'],
['/', 'left'],
['%', 'left'],
['==', 'left'],
['!=', 'left'],
['<', 'left'],
['<=', 'left'],
['>', 'left'],
['>=', 'left'],
['&&', 'left'],
[' ', 'left'],
].map(([op, assoc]) =>
prec[assoc](seq(field('left', $._expression), op, field('right', $._expression)))
)
),

unary_expression: $ => prec.right(seq(choice('-', '!'), $._expression)),

parenthesized_expression: $ => seq('(', $._expression, ')'),

// 基本类型
_type: $ => choice(
$.identifier,
$.array_type,
$.function_type
),

array_type: $ => seq('[', $._type, ']'),

function_type: $ => seq(
$.parameter_list,
'->',
$._type
),

// 基本元素
identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]/,

string: $ => choice(
seq('"', /[^"]/, '"'),
seq("'", /[^']/, "'")
),

number: $ => /0 [1-9][0-9] 0x[0-9a-fA-F]+ 0b[01]+/,

boolean: $ => choice('true', 'false'),

comment: $ => token(seq('//', /./)),
}
});

function commaSep(rule) {
return optional(commaSep1(rule));
}

function commaSep1(rule) {
return seq(
rule,
repeat(seq(',', rule)),
optional(',')
);
}

json
// extension.json
{
"id": "cangjie",
"name": "Cangjie",
"version": "0.1.0",
"description": "Cangjie programming language support for Zed",
"repository": {
"type": "git",
"url": "https://github.com/cangjie-lang/cangjie-zed-extension"
},
"authors": [
"Cangjie Team"
],
"language_servers": {
"cangjie-lsp": {
"name": "Cangjie Language Server",
"language": "cangjie",
"config": {
"provideFormatter": true,
"enableSemanticHighlighting": true
},
"variants": {
"x86_64-unknown-linux-gnu": {
"url": "https://github.com/cangjie-lang/cangjie-lsp/releases/download/v0.1.0/cangjie-lsp-x86_64-unknown-linux-gnu.tar.gz",
"sha256": "..."
},
"aarch64-unknown-linux-gnu": {
"url": "https://github.com/cangjie-lang/cangjie-lsp/releases/download/v0.1.0/cangjie-lsp-aarch64-unknown-linux-gnu.tar.gz",
"sha256": "..."
},
"x86_64-apple-darwin": {
"url": "https://github.com/cangjie-lang/cangjie-lsp/releases/download/v0.1.0/cangjie-lsp-x86_64-apple-darwin.tar.gz",
"sha256": "..."
},
"aarch64-apple-darwin": {
"url": "https://github.com/cangjie-lang/cangjie-lsp/releases/download/v0.1.0/cangjie-lsp-aarch64-apple-darwin.tar.gz",
"sha256": "..."
},
"x86_64-pc-windows-msvc": {
"url": "https://github.com/cangjie-lang/cangjie-lsp/releases/download/v0.1.0/cangjie-lsp-x86_64-pc-windows-msvc.zip",
"sha256": "..."
}
}
}
},
"languages": [
{
"name": "Cangjie",
"grammar": "cangjie",
"path_suffixes": ["cj", "cangjie"],
"line_comments": ["// "],
"block_comment": ["/", "*/"],
"brackets": [
{
"start": "{",
"end": "}",
"close": true,
"newline": true
},
{
"start": "[",
"end": "]",
"close": true,
"newline": false
},
{
"start": "(",
"end": ")",
"close": true,
"newline": false
}
],
"tab_size": 4,
"hard_tabs": false,
"indentation_based_folding": true,
"overrides": {}
}
],
"grammars": {
"cangjie": {
"language": "cangjie",
"path": "./tree-sitter-cangjie.wasm"
}
},
"tasks": [
{
"label": "Run Cangjie Program",
"command": "cangjie",
"args": ["run", "${file}"],
"cwd": "${fileDirname}"
},
{
"label": "Build Cangjie Project",
"command": "cangjie",
"args": ["build", "${file}"],
"cwd": "${fileDirname}"
}
]
}

rust
// build.rs
use std::env;
use std::path::PathBuf;

fn main() {
// 获取项目根目录
let project_dir = PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap());

// 编译tree-sitter-cangjie解析器
let tree_sitter_dir = project_dir.join("tree-sitter-cangjie");
if tree_sitter_dir.exists() {
let src_dir = tree_sitter_dir.join("src");
if src_dir.exists() {
let parser_file = src_dir.join("parser.c");
if parser_file.exists() {
cc::Build::new()
.file(&parser_file)
.include(&src_dir)
.compile("tree-sitter-cangjie");
}

// 如果有scanner.c也一起编译
let scanner_file = src_dir.join("scanner.c");
if scanner_file.exists() {
cc::Build::new()
.file(&scanner_file)
.include(&src_dir)
.compile("tree-sitter-cangjie-scanner");
}
}
}

// 监视相关文件变化
println!("cargo:rerun-if-changed=src/");
println!("cargo:rerun-if-changed=tree-sitter-cangjie/");
println!("cargo:rerun-if-changed=extension.json");
}

markdown
Cangjie Language Extension for Zed

This extension provides comprehensive support for the Cangjie programming language in Zed editor.
Features
Syntax highlighting with tree-sitter
Language Server Protocol (LSP) support
Code completion
Go to definition
Find references
Hover documentation
Formatting
Error reporting
Task templates for running and building Cangjie programs
Installation

The extension will automatically download the required language server binary when first used.
Configuration

The extension can be configured in Zed's settings:
enableSemanticHighlighting: Enable semantic syntax highlighting
maxFileSize: Maximum file size in bytes for language server processing
checkOnSave: Enable checking on file save
Tree-sitter Grammar

The extension includes a custom tree-sitter grammar for Cangjie that supports:
Function definitions
Variable declarations
Struct and enum definitions
Interface definitions
Control flow statements
Expressions and operators
Comments and string literals
Development

To build the extension:

1. Install Rust and Cargo
2. Run cargo build to build the extension
3. The extension can be loaded in Zed for testing
Language Server

The extension integrates with the official Cangjie language server that provides:
Diagnostics
Code completion
Go to definition
Find references
Formatting
Hover information

javascript
// scripts/build-grammar.js
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

function buildTreeSitterGrammar() {
try {
// 检查是否有tree-sitter CLI
execSync('npm list -g tree-sitter-cli npm install -g tree-sitter-cli', { stdio: 'pipe' });

const grammarDir = path.join(__dirname, '..', 'tree-sitter-cangjie');

if (fs.existsSync(grammarDir)) {
process.chdir(grammarDir);

// 生成解析器
console.log('Generating tree-sitter parser...');
execSync('tree-sitter generate', { stdio: 'inherit' });

// 构建WASM版本
console.log('Building WASM parser...');
execSync('tree-sitter build-wasm', { stdio: 'inherit' });

// 复制到扩展目录
const wasmFile = path.join(grammarDir, 'tree-sitter-cangjie.wasm');
const targetDir = path.join(__dirname, '..');
const targetFile = path.join(targetDir, 'tree-sitter-cangjie.wasm');

if (fs.existsSync(wasmFile)) {
fs.copyFileSync(wasmFile, targetFile);
console.log('WASM parser copied to extension root');
}
} else {
console.log('tree-sitter-cangjie directory not found, skipping grammar build');
}
} catch (error) {
console.error('Error building tree-sitter grammar:', error.message);
}
}

buildTreeSitterGrammar();

bash
#!/bin/bash
build.sh - 构建脚本

set -e

echo "Building Cangjie extension for Zed..."
检查Rust工具链
if ! command -v rustc &> /dev/null; then
echo "Rust is not installed. Please install Rust from https://rustup.rs/"
exit 1
fi
检查Cargo
if ! command -v cargo &> /dev/null; then
echo "Cargo is not installed. Please install Rust from https://rustup.rs/"
exit 1
fi
构建扩展
echo "Building extension..."
cargo build --release
构建tree-sitter语法
echo "Building tree-sitter grammar..."
node scripts/build-grammar.js

echo "Build completed successfully!"
echo "The extension is ready to be loaded in Zed."
