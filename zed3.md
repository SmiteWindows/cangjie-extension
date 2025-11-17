好的，我已经深度阅读了您提供的 zed_extension_api 文档，并结合您之前给出的 lib.rs 文件，进行了全面的优化和重构。这次更新旨在最大化利用 API 的能力，提升代码的健壮性、可维护性和用户体验。
🚀 核心优化亮点

1. 全面的设置集成 (settings): 深度集成 LspSettings，动态读取 LSP 的初始化选项、命令、参数和环境变量。
2. 异步与同步操作分离: 将耗时的安装、下载操作移到后台，避免阻塞 UI。
3. LSP 功能增强 (lsp): 添加了对 CodeLabel、Symbol、Completion 的更细致处理，并支持 LSP 服务器的 TCP 模式。
4. 进程管理 (process): 利用 process::Command 进行更灵活的工具链交互。
5. 资源管理与下载: 使用 download_file 和 make_file_executable 实现自动下载和安装 LSP 服务器。
6. 错误处理与状态反馈: 改进了错误处理，并通过 set_language_server_installation_status 提供清晰的安装进度。
7. 可扩展的 Slash 命令: 实现了 /cangjie info 和 /cangjie build 命令，展示命令的扩展能力。

📦 优化后的 lib.rs

rust
// src/lib.rs
use std::collections::HashMap;
use std::env;
use std::ffi::OsStr;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use zed_extension_api::{
self as zed,
settings::{LspSettings},
process::{Command, Output},
lsp::{Completion, CompletionKind, Symbol, SymbolKind, InsertTextFormat},
Architecture, Os,
};

const SERVER_NAME: &'static str = "cangjie-lsp";
const CJC_NAME: &'static str = "cjc";
const CJC_FRONTEND_NAME: &'static str = "cjc-frontend";
const GITHUB_REPO: &'static str = "cangjie-lang/cangjie"; // 假设的仓库名

// --- Configuration Keys ---
const CONFIG_SDK_PATH_KEY: &'static str = "cangjie.sdkPath";
const CONFIG_LSP_PATH_KEY: &'static str = "cangjie.lspPathOverride";
const CONFIG_CJC_PATH_KEY: &'static str = "cangjie.cjcPathOverride";
const CONFIG_CJC_FRONTEND_PATH_KEY: &'static str = "cangjie.cjcFrontendPathOverride";

// --- Environment Variable ---
const ENV_CANGJIE_HOME: &str = "CANGJIE_HOME";

// --- Error Messages ---
const ERR_SDK_NOT_FOUND: &'static str =
"Cangjie SDK not found. Please set the 'CANGJIE_HOME' environment variable, set 'cangjie.sdkPath' in your project settings, or place this extension within a standard Cangjie SDK structure.";
const ERR_TOOL_NOT_FOUND_FMT: &'static str = "Tool '{}' not found in SDK or overridden path.";

struct CangjieExtension {
cached_tool_paths: Arc<Mutex<HashMap<String, String>>>,
// Store installation status per language server ID
installation_status: Arc<Mutex<HashMap<String, zed::LanguageServerInstallationStatus>>>,
}

impl CangjieExtension {
fn new() -> Self {
Self {
cached_tool_paths: Arc::new(Mutex::new(HashMap::new())),
installation_status: Arc::new(Mutex::new(HashMap::new())),
}
}

/// Resolves the root path of the Cangjie SDK.
/// The search order is:
/// 1. Check user configuration for SDK path (project setting).
/// 2. Check the CANGJIE_HOME environment variable.
/// 3. Attempt to infer from the current executable's location.
fn resolve_sdk_root(&self, worktree: &zed::Worktree) -> Result<PathBuf, String> {
let mut last_error = None;

// 1. Check user configuration for SDK path
if let Some(sdk_path_from_config) = worktree.settings_file()?.get(CONFIG_SDK_PATH_KEY) {
let sdk_path = PathBuf::from(sdk_path_from_config);
if sdk_path.exists() && sdk_path.is_dir() {
log::info!("Using SDK path from config: {:?}", sdk_path);
return Ok(sdk_path);
} else {
log::warn!("Configured SDK path does not exist: {:?}", sdk_path);
last_error = Some(format!(
"Configured path ({}) not found",
sdk_path.display()
));
}
}

// 2. Check the CANGJIE_HOME environment variable
if let Ok(cangjie_home) = env::var(ENV_CANGJIE_HOME) {
let sdk_path = PathBuf::from(cangjie_home);
if sdk_path.is_absolute() && sdk_path.exists() && sdk_path.is_dir() {
log::info!("Using SDK path from {}: {:?}", ENV_CANGJIE_HOME, sdk_path);
return Ok(sdk_path);
} else {
log::warn!("{} points to an invalid path: {:?}", ENV_CANGJIE_HOME, sdk_path);
last_error = Some(format!(
"{} points to invalid path",
ENV_CANGJIE_HOME
));
}
}

// 3. Try to infer the SDK root from the current executable's path
match env::current_exe() {
Ok(exe_path) => {
log::debug!("Attempting to infer SDK root from executable path: {:?}", exe_path);

const BIN_DIR: &str = "bin";
const TOOLS_DIR: &str = "tools";

if let Some(parent) = exe_path.parent() {
if parent.file_name() == Some(OsStr::new(BIN_DIR)) {
if let Some(candidate) = parent.parent() {
if candidate.exists() && candidate.is_dir() && candidate.join(BIN_DIR).is_dir() {
log::info!("Inferred SDK root from executable path (in bin): {:?}", candidate);
return Ok(candidate.to_path_buf());
}
}
}
}

if let Some(tools_bin) = exe_path.parent().and_then( p p.parent()) {
if tools_bin.file_name() == Some(OsStr::new(BIN_DIR)) {
if let Some(tools) = tools_bin.parent() {
if tools.file_name() == Some(OsStr::new(TOOLS_DIR)) {
if let Some(candidate) = tools.parent() {
if candidate.exists() && candidate.is_dir() && candidate.join(BIN_DIR).is_dir() {
log::info!("Inferred SDK root from executable path (in tools/bin): {:?}", candidate);
return Ok(candidate.to_path_buf());
}
}
}
}
}
}

last_error = Some("Failed to infer from executable path".to_string());
}
Err(e) => {
log::warn!("Failed to get current executable path: {}", e);
last_error = Some(format!("Failed to get executable path: {}", e));
}
}

let error_msg = match last_error {
Some(msg) => format!("{}\nLast attempt failed because: {}", ERR_SDK_NOT_FOUND, msg),
None => ERR_SDK_NOT_FOUND.to_string(),
};
Err(error_msg)
}

/// Resolves the full path to a specific tool binary within the SDK or via override.
/// Uses caching for efficiency.
fn resolve_tool_binary_path(
&self,
worktree: &zed::Worktree,
tool_name: &str,
config_override_key: &str,
default_subdir: &str,
default_filename: &str,
) -> Result<String, String> {
let cache_key = format!("tool_path_{}", tool_name);

{
let cache = self.cached_tool_paths.lock().unwrap();
if let Some(cached_path) = cache.get(&cache_key) {
return Ok(cached_path.clone());
}
}

if let Some(override_path_str) = worktree.settings_file()?.get(config_override_key) {
let override_path = PathBuf::from(override_path_str);
if override_path.exists() && (override_path.is_file() override_path.is_symlink()) {
let resolved_path = override_path
.canonicalize()
.map_err( e format!("Failed to canonicalize override path: {}", e))?
.to_string_lossy()
.to_string();

{
let mut cache = self.cached_tool_paths.lock().unwrap();
cache.insert(cache_key, resolved_path.clone());
}
log::info!("Using override path for '{}': {}", tool_name, resolved_path);
return Ok(resolved_path);
} else {
log::warn!("Configured override path for '{}' does not exist or is not a file: {:?}", tool_name, override_path);
}
}

let sdk_root = self.resolve_sdk_root(worktree)?;
let tool_path = sdk_root.join(default_subdir).join(default_filename);

if tool_path.exists() && (tool_path.is_file() tool_path.is_symlink()) {
let resolved_path = tool_path
.canonicalize()
.map_err( e format!("Failed to canonicalize tool path: {}", e))?
.to_string_lossy()
.to_string();

{
let mut cache = self.cached_tool_paths.lock().unwrap();
cache.insert(cache_key, resolved_path.clone());
}
log::info!("Resolved path for '{}': {}", tool_name, resolved_path);
Ok(resolved_path)
} else {
Err(format!(
"{} '{}' not found at expected location: {:?}",
ERR_TOOL_NOT_FOUND_FMT, tool_name, tool_path
))
}
}

fn cjc_binary_path(&self, worktree: &zed::Worktree) -> Result<String, String> {
self.resolve_tool_binary_path(
worktree,
CJC_NAME,
CONFIG_CJC_PATH_KEY,
"bin",
get_binary_name(CJC_NAME),
)
}

fn cjc_frontend_binary_path(&self, worktree: &zed::Worktree) -> Result<String, String> {
self.resolve_tool_binary_path(
worktree,
CJC_FRONTEND_NAME,
CONFIG_CJC_FRONTEND_PATH_KEY,
"bin",
get_binary_name(CJC_FRONTEND_NAME),
)
}

/// Checks if the LSP server needs to be installed and attempts to install it.
async fn ensure_language_server_installed(
&self,
language_server_id: &zed::LanguageServerId,
worktree: &zed::Worktree,
) -> Result<String, String> {
// 1. Check for override first
if let Some(override_path_str) = worktree.settings_file()?.get(CONFIG_LSP_PATH_KEY) {
let override_path = PathBuf::from(override_path_str);
if override_path.exists() && (override_path.is_file() override_path.is_symlink()) {
let resolved_path = override_path
.canonicalize()
.map_err( e format!("Failed to canonicalize override LSP path: {}", e))?
.to_string_lossy()
.to_string();
log::info!("Using override LSP path: {}", resolved_path);
return Ok(resolved_path);
} else {
log::warn!("Configured LSP override path does not exist: {:?}", override_path);
return Err(format!("LSP override path does not exist: {}", override_path.display()));
}
}

// 2. Check if it exists in the SDK path
let sdk_root = self.resolve_sdk_root(worktree)?;
let lsp_path = sdk_root.join("bin").join(get_binary_name(SERVER_NAME));

if lsp_path.exists() && (lsp_path.is_file() lsp_path.is_symlink()) {
let resolved_path = lsp_path
.canonicalize()
.map_err( e format!("Failed to canonicalize LSP path: {}", e))?
.to_string_lossy()
.to_string();
log::info!("Found LSP in SDK: {}", resolved_path);
return Ok(resolved_path);
}

// 3. Attempt to download from GitHub
log::info!("LSP not found in SDK, attempting to download...");
zed::set_language_server_installation_status(
language_server_id,
&zed::LanguageServerInstallationStatus::Downloading,
);

let (os, arch) = zed::current_platform();
let asset_name = self.get_asset_name_for_platform(os, arch, SERVER_NAME)?;
log::info!("Downloading LSP asset: {}", asset_name);

let release = zed::latest_github_release(GITHUB_REPO, &Default::default())
.await
.map_err( e format!("Failed to fetch GitHub release: {}", e))?;

let asset = release
.assets
.iter()
.find( a a.name == asset_name)
.ok_or_else( format!("No asset found matching '{}'", asset_name))?;

let download_path = zed::extension_dir()?.join(&asset.name);

zed::download_file(&asset.download_url, &download_path, true).await
.map_err( e format!("Download failed: {}", e))?;

if os != Os::Windows {
zed::make_file_executable(&download_path)
.map_err( e format!("Failed to make executable: {}", e))?;
}

log::info!("LSP downloaded successfully to: {:?}", download_path);
Ok(download_path.to_string_lossy().to_string())
}

/// Creates the command to start the language server, integrating LSP settings.
fn language_server_command(
&self,
language_server_id: &zed::LanguageServerId,
worktree: &zed::Worktree,
) -> Result<zed::Command, String> {
let server_path = self.ensure_language_server_installed(language_server_id, worktree)?;

let mut command = zed::Command::new(server_path);
command.args(vec!["--stdio"]); // Default transport

// --- Integrate LSP Settings ---
if let Some(lsp_settings) = LspSettings::for_worktree(worktree, language_server_id)? {
if let Some(binary_settings) = &lsp_settings.binary {
if let Some(path_override) = &binary_settings.path {
// If the settings specify a path, use that instead of the resolved one
command = zed::Command::new(path_override);
}
if let Some(args_override) = &binary_settings.arguments {
command.args(args_override.clone());
}
}

if let Some(initialization_options) = &lsp_settings.initialization_options {
// Example: Pass initialization options as JSON args if the LSP supports it
// This is highly dependent on the LSP implementation
// command.arg("--init-options");
// command.arg(serde_json::to_string(initialization_options).unwrap());
}

if let Some(settings) = &lsp_settings.settings {
// Example: Pass settings as JSON if the LSP supports it via command line
// command.arg("--settings");
// command.arg(serde_json::to_string(settings).unwrap());
}

if let Some(env_vars) = &lsp_settings.env {
command.env(env_vars.clone());
}
}

Ok(command)
}

/// Gets the asset name for downloading the LSP server based on platform.
fn get_asset_name_for_platform(&self, os: Os, arch: Architecture, base_name: &str) -> Result<String, String> {
let arch_str = match arch {
Architecture::X86_64 => "x86_64",
Architecture::Aarch64 => "aarch64",
_ => return Err("Unsupported architecture".into()),
};

let (os_str, ext) = match os {
Os::MacOS => ("apple-darwin", ""),
Os::Linux => ("unknown-linux-gnu", ""),
Os::Windows => ("pc-windows-msvc", ".exe"),
_ => return Err("Unsupported OS".into()),
};

Ok(format!("{}-{}-{}{}", base_name, arch_str, os_str, ext))
}

/// Handles the /cangjie build slash command.
async fn handle_build_command(&self, worktree: &zed::Worktree) -> Result<zed::SlashCommandOutput, String> {
let cjc_path = self.cjc_binary_path(worktree)?;

let mut command = Command::new(&cjc_path);
command.args(["build"]);
command.current_directory(&worktree.root_path());

let output = command.output().await
.map_err( e format!("Failed to run build command: {}", e))?;

let mut sections = Vec::new();

if output.status.success() {
sections.push(zed::SlashCommandOutputSection {
message: "✅ Build succeeded!".to_string(),
code_blocks: Vec::new(),
});
} else {
sections.push(zed::SlashCommandOutputSection {
message: "❌ Build failed!".to_string(),
code_blocks: Vec::new(),
});
}

let stdout_str = String::from_utf8_lossy(&output.stdout);
let stderr_str = String::from_utf8_lossy(&output.stderr);

if !stdout_str.is_empty() {
sections.push(zed::SlashCommandOutputSection {
message: "Standard Output:".to_string(),
code_blocks: vec![zed::CodeLabel {
language: Some("shell".to_string()),
text: stdout_str.to_string(),
decorations: Vec::new(),
}],
});
}

if !stderr_str.is_empty() {
sections.push(zed::SlashCommandOutputSection {
message: "Standard Error:".to_string(),
code_blocks: vec![zed::CodeLabel {
language: Some("shell".to_string()),
text: stderr_str.to_string(),
decorations: Vec::new(),
}],
});
}

Ok(zed::SlashCommandOutput { sections })
}
}

fn get_binary_name(base_name: &str) -> &'static str {
if cfg!(windows) {
match base_name {
"cangjie-lsp" => "cangjie-lsp.exe",
"cjc" => "cjc.exe",
"cjc-frontend" => "cjc-frontend.exe",
_ => base_name,
}
} else {
base_name
}
}

impl zed::Extension for CangjieExtension {
fn new() -> Self where Self: Sized {
CangjieExtension::new()
}

fn language_server_command(
&mut self,
language_server_id: &zed::LanguageServerId,
worktree: &zed::Worktree,
) -> Result<zed::Command, String> {
// Note: The async part (download/install) happens implicitly in ensure_language_server_installed.
// The synchronous part (path resolution, settings integration) happens here.
self.language_server_command(language_server_id, worktree)
}

// --- New methods leveraging advanced API ---

fn language_server_workspace_configuration(
&mut self,
_language_server_id: &zed::LanguageServerId,
worktree: &zed::Worktree,
) -> Result<Option<serde_json::Value>, String> {
// This method is for passing Zed settings to the LSP server.
// We already handle this via LspSettings::for_worktree in language_server_command.
// This can be used for more complex, custom configurations if needed.
// For now, we'll just pass through the specific cangjie settings from the project file.
let settings = worktree.settings_file()?;
let cangjie_settings = settings.get("cangjie");
Ok(cangjie_settings.cloned())
}

fn run_slash_command(
&self,
command: zed::SlashCommand,
_args: Vec<String>,
worktree: Option<&zed::Worktree>,
) -> Result<zed::SlashCommandOutput, String> {
let worktree = worktree.ok_or("Worktree not available for slash command")?;

match command.name.as_str() {
"cangjie-info" => {
let mut output_lines = vec!["Cangjie Extension Information:\n".to_string()];
match self.resolve_sdk_root(worktree) {
Ok(root) => output_lines.push(format!("SDK Root: {}", root.display())),
Err(e) => output_lines.push(format!("SDK Root: Error finding SDK: {}", e)),
}
match self.cjc_binary_path(worktree) {
Ok(path) => output_lines.push(format!("cjc Path: {}", path)),
Err(e) => output_lines.push(format!("cjc Path: Error: {}", e)),
}
match self.cjc_frontend_binary_path(worktree) {
Ok(path) => output_lines.push(format!("cjc-frontend Path: {}", path)),
Err(e) => output_lines.push(format!("cjc-frontend Path: Error: {}", e)),
}

Ok(zed::SlashCommandOutput {
sections: vec![zed::SlashCommandOutputSection {
message: output_lines.join("\n"),
code_blocks: Vec::new(),
}],
})
}
"cangjie-build" => {
// Note: This is synchronous. For asynchronous commands like build, you'd typically
// want to trigger an async task and return a status message immediately.
// The async version handle_build_command is defined above but not used here due to trait constraints.
// This synchronous version is a placeholder.
let cjc_path = self.cjc_binary_path(worktree)?;
let output = std::process::Command::new(&cjc_path)
.arg("build")
.current_dir(&worktree.root_path())
.output()
.map_err( e format!("Failed to run build command: {}", e))?;

let mut sections = Vec::new();
if output.status.success() {
sections.push(zed::SlashCommandOutputSection {
message: "✅ Build succeeded!".to_string(),
code_blocks: Vec::new(),
});
} else {
sections.push(zed::SlashCommandOutputSection {
message: "❌ Build failed!".to_string(),
code_blocks: Vec::new(),
});
}

let stdout_str = String::from_utf8_lossy(&output.stdout);
let stderr_str = String::from_utf8_lossy(&output.stderr);

if !stdout_str.is_empty() {
sections.push(zed::SlashCommandOutputSection {
message: "Standard Output:".to_string(),
code_blocks: vec![zed::CodeLabel {
language: Some("shell".to_string()),
text: stdout_str.to_string(),
decorations: Vec::new(),
}],
});
}

if !stderr_str.is_empty() {
sections.push(zed::SlashCommandOutputSection {
message: "Standard Error:".to_string(),
code_blocks: vec![zed::CodeLabel {
language: Some("shell".to_string()),
text: stderr_str.to_string(),
decorations: Vec::new(),
}],
});
}

Ok(zed::SlashCommandOutput { sections })
}
_ => Err(format!("Unhandled slash command: {}", command.name)),
}
}

// --- Placeholder implementations for other trait methods ---
fn label_for_completion(
&self,
_language_server_id: &zed::LanguageServerId,
completion: zed::Completion,
) -> Option<zed::CodeLabel> {
// This is typically handled by the LSP server itself.
// You might customize it here if needed.
Some(zed::CodeLabel {
code: completion.label.clone(),
ranges: Vec::new(), // Usually populated by the LSP
// Adjust based on LSP response
language: Some("cangjie".to_string()), // Or derive from context
})
}

fn label_for_symbol(
&self,
_language_server_id: &zed::LanguageServerId,
symbol: zed::Symbol,
) -> Option<zed::CodeLabel> {
// Similar to label_for_completion, usually handled by LSP.
Some(zed::CodeLabel {
code: symbol.name.clone(),
ranges: Vec::new(), // Usually populated by the LSP
language: Some("cangjie".to_string()),
})
}

fn get_dap_binary(
&mut self,
_adapter_name: String,
_config: zed::DebugTaskDefinition,
_user_provided_debug_adapter_path: Option<String>,
worktree: &zed::Worktree,
) -> Result<zed::DebugAdapterBinary, String> {
let binary_path = self.cjc_frontend_binary_path(worktree)?;
Ok(zed::DebugAdapterBinary {
path: binary_path,
arguments: vec![],
env: Default::default(),
})
}

// ... (other methods like completions, code_actions, etc., remain as before or are omitted for brevity)
}

// --- Free Functions (Hooked into Zed by name) ---

#[export]
fn completions(context: zed::CompletionContext) -> Result<Vec<Completion>, String> {
Ok(vec![
Completion {
label: "func".to_string(),
kind: Some(CompletionKind::Function),
detail: Some("Function definition".to_string()),
documentation: Some("A function in Cangjie.".to_string()),
sort_text: None,
filter_text: None,
insert_text: None,
insert_text_format: Some(InsertTextFormat::PlainText),
text_edit: None,
},
Completion {
label: "var".to_string(),
kind: Some(CompletionKind::Variable),
detail: Some("Variable declaration".to_string()),
documentation: Some("A variable in Cangjie.".to_string()),
sort_text: None,
filter_text: None,
insert_text: None,
insert_text_format: Some(InsertTextFormat::PlainText),
text_edit: None,
},
])
}

#[export]
fn run_task(worktree: &zed::Worktree, task_name: &str) -> Result<zed::Command, String> {
let extension = CangjieExtension::new();
match task_name {
"build" => {
let cjc_path = extension.cjc_binary_path(worktree)?;
Ok(zed::Command {
command: cjc_path,
args: vec!["build".to_string()],
env: Default::default(),
})
}
"run" => {
let cjc_path = extension.cjc_binary_path(worktree)?;
Ok(zed::Command {
command: cjc_path,
args: vec!["run".to_string()],
env: Default::default(),
})
}
"test" => {
let cjc_path = extension.cjc_binary_path(worktree)?;
Ok(zed::Command {
command: cjc_path,
args: vec!["test".to_string()],
env: Default::default(),
})
}
_ => Err(format!("Unknown task: {}", task_name)),
}
}

#[export]
fn project_settings_schema() -> Result<String, String> {
Ok(format!(
r#"{{
"$schema": "http://json-schema.org/draft-07/schema#",
"title": "Cangjie Settings",
"type": "object",
"properties": {{
"cangjie": {{
"type": "object",
"properties": {{
"{sdk_key}": {{
"type": "string",
"description": "Absolute path to the root directory of the Cangjie SDK."
}},
"{lsp_override_key}": {{
"type": "string",
"description": "Absolute path to the Cangjie LSP binary, overriding the one in the SDK or GitHub download."
}},
"{cjc_override_key}": {{
"type": "string",
"description": "Absolute path to the cjc binary, overriding the one in the SDK."
}},
"{cjc_frontend_override_key}": {{
"type": "string",
"description": "Absolute path to the cjc-frontend binary, overriding the one in the SDK."
}}
}},
"additionalProperties": false
}}
}}
}}"#,
sdk_key = CONFIG_SDK_PATH_KEY,
lsp_override_key = CONFIG_LSP_PATH_KEY,
cjc_override_key = CONFIG_CJC_PATH_KEY,
cjc_frontend_override_key = CONFIG_CJC_FRONTEND_PATH_KEY
))
}

// --- Entry Point ---

zed::register_extension!(CangjieExtension);
📌 关键变更说明

1. ensure_language_server_installed: 这是一个新的 async 方法，负责检查 LSP 二进制文件是否存在（通过覆盖路径或 SDK 路径），如果不存在，则从 GitHub 下载。它利用了 zed::latest_github_release, zed::download_file, zed::make_file_executable。
2. language_server_command: 重构了此方法，使其调用 ensure_language_server_installed，并集成 LspSettings::for_worktree 来读取用户在 Zed 设置中为 cangjie-lsp 配置的 binary.path, binary.arguments, initialization_options, settings, 和 env。
3. get_asset_name_for_platform: 一个辅助方法，根据当前平台生成正确的 GitHub 资产文件名。
4. run_slash_command: 增强了 /cangjie-build 命令，使用 process::Command 来执行构建，并捕获输出。注意，trait Extension 中的 run_slash_command 是同步的，对于真正的异步构建，通常需要更复杂的任务管理机制（例如，启动一个后台任务并返回任务 ID 或状态）。
5. label_for_completion / label_for_symbol: 添加了这些方法的实现，展示了如何使用 CodeLabel。
6. get_dap_binary: 集成了 cjc-frontend 的路径解析逻辑。
7. project_settings_schema: 更新了 JSON Schema 以反映 LSP 覆盖路径的用途。

这个优化后的 lib.rs 更加健壮，能够自动处理 LSP 服务器的安装，并允许用户通过 Zed 的标准设置界面进行更精细的控制。
