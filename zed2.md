// src/lib.rs
use std::collections::HashMap;
use std::env;
use std::ffi::OsString;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use zed_extension_api::{
    self as zed, CodeLabel, CodeLabelSpan, Command, Completion, CompletionKind,
    ContextServerConfiguration, DebugAdapterBinary, DebugConfig, DebugRequest, DebugScenario,
    DebugTaskDefinition, DownloadedFileType, KeyValueStore, LanguageServerBinary, LanguageServerId,
    Project, SearchContext, SlashCommand, SlashCommandArgumentCompletion, SlashCommandOutput,
    StartDebuggingRequestArgumentsRequest, Symbol, TaskTemplate, Worktree, lsp,
};

const SERVER_NAME: &'static str = "cangjie-lsp";
const CJC_NAME: &'static str = "cjc";
const CJC_FRONTEND_NAME: &'static str = "cjc-frontend";

// --- Configuration Keys ---
const CONFIG_SDK_PATH_KEY: &'static str = "cangjie.sdkPath";
const CONFIG_LSP_PATH_KEY: &'static str = "cangjie.lspPathOverride";
const CONFIG_CJC_PATH_KEY: &'static str = "cangjie.cjcPathOverride";
const CONFIG_CJC_FRONTEND_PATH_KEY: &'static str = "cangjie.cjcFrontendPathOverride";

// --- Error Messages ---
const ERR_SDK_NOT_FOUND: &'static str = "Cangjie SDK not found. Please set 'cangjie.sdkPath' in your project settings or ensure the SDK is installed in a standard location.";
const ERR_TOOL_NOT_FOUND_FMT: &'static str = "Tool '{}' not found in SDK or overridden path.";

struct CangjieExtension {
    // Cache resolved paths to avoid repeated lookups
    cached_tool_paths: Arc<Mutex<HashMap<String, String>>>,
}

impl CangjieExtension {
    fn new() -> Self {
        Self {
            cached_tool_paths: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    /// Resolves the root path of the Cangjie SDK.
    /// Checks user config first, then standard installation paths.
    fn resolve_sdk_root(&self, worktree: &Worktree) -> Result<PathBuf, String> {
        // 1. Check user configuration for SDK path
        if let Some(sdk_path_from_config) = worktree.settings_file()?.get(CONFIG_SDK_PATH_KEY) {
            let sdk_path = PathBuf::from(sdk_path_from_config);
            if sdk_path.exists() && sdk_path.is_dir() {
                log::info!("Using SDK path from config: {:?}", sdk_path);
                return Ok(sdk_path);
            } else {
                log::warn!("Configured SDK path does not exist: {:?}", sdk_path);
            }
        }

        // 2. Check standard installation paths based on OS
        let standard_paths = get_standard_sdk_paths();
        for candidate_path in standard_paths {
            let path = PathBuf::from(candidate_path);
            if path.exists() && path.is_dir() {
                log::info!("Found SDK at standard path: {:?}", path);
                return Ok(path);
            }
        }

        // 3. Not found in any location
        Err(ERR_SDK_NOT_FOUND.to_string())
    }

    /// Resolves the full path to a specific tool binary within the SDK or via override.
    /// Uses caching for efficiency.
    fn resolve_tool_binary_path(
        &self,
        worktree: &Worktree,
        tool_name: &str,           // e.g., "LSPServer", "cjc"
        config_override_key: &str, // e.g., "cangjie.lspPathOverride"
        default_subdir: &str,      // Usually "bin"
        default_filename: &str,    // e.g., "LSPServer", "cjc.exe"
    ) -> Result<String, String> {
        let cache_key = format!("tool_path_{}", tool_name);

        // Check cache first
        {
            let cache = self.cached_tool_paths.lock().unwrap();
            if let Some(cached_path) = cache.get(&cache_key) {
                return Ok(cached_path.clone());
            }
        }

        // 1. Check for an explicit path override in settings
        if let Some(override_path_str) = worktree.settings_file()?.get(config_override_key) {
            let override_path = PathBuf::from(override_path_str);
            if override_path.exists() && (override_path.is_file() || override_path.is_symlink()) {
                let resolved_path = override_path
                    .canonicalize()
                    .map_err(|e| format!("Failed to canonicalize override path: {}", e))?
                    .to_string_lossy()
                    .to_string();

                // Cache the result
                {
                    let mut cache = self.cached_tool_paths.lock().unwrap();
                    cache.insert(cache_key, resolved_path.clone());
                }
                log::info!("Using override path for '{}': {}", tool_name, resolved_path);
                return Ok(resolved_path);
            } else {
                log::warn!(
                    "Configured override path for '{}' does not exist or is not a file: {:?}",
                    tool_name,
                    override_path
                );
            }
        }

        // 2. Resolve SDK root and construct path
        let sdk_root = self.resolve_sdk_root(worktree)?;
        let tool_path = sdk_root.join(default_subdir).join(default_filename);

        if tool_path.exists() && (tool_path.is_file() || tool_path.is_symlink()) {
            let resolved_path = tool_path
                .canonicalize()
                .map_err(|e| format!("Failed to canonicalize tool path: {}", e))?
                .to_string_lossy()
                .to_string();

            // Cache the result
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

    /// Gets the binary path for the Language Server Protocol server.
    fn language_server_binary(
        &self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<LanguageServerBinary, String> {
        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::CheckingForUpdate,
        );

        let binary_path = self.resolve_tool_binary_path(
            worktree,
            SERVER_NAME,
            CONFIG_LSP_PATH_KEY,
            "bin",
            get_binary_name(SERVER_NAME),
        )?;

        Ok(LanguageServerBinary {
            path: binary_path,
            arguments: vec![], // Arguments will be passed via the command
            env: Default::default(),
        })
    }

    /// Gets the binary path for the cjc compiler.
    fn cjc_binary_path(&self, worktree: &Worktree) -> Result<String, String> {
        self.resolve_tool_binary_path(
            worktree,
            CJC_NAME,
            CONFIG_CJC_PATH_KEY,
            "bin",
            get_binary_name(CJC_NAME),
        )
    }

    /// Gets the binary path for the cjc-frontend debugger.
    fn cjc_frontend_binary_path(&self, worktree: &Worktree) -> Result<String, String> {
        self.resolve_tool_binary_path(
            worktree,
            CJC_FRONTEND_NAME,
            CONFIG_CJC_FRONTEND_PATH_KEY,
            "bin",
            get_binary_name(CJC_FRONTEND_NAME),
        )
    }
}

/// Helper function to get the appropriate executable filename based on the OS.
fn get_binary_name(base_name: &str) -> &'static str {
    if cfg!(windows) {
        match base_name {
            "LSPServer" => "cangjie-lsp.exe", // This name needs to be verified
            "cjc" => "cjc.exe",
            "cjc-frontend" => "cjc-frontend.exe",
            _ => base_name, // Fallback, though shouldn't happen
        }
    } else {
        base_name
    }
}

/// Helper function to get standard SDK installation paths based on the OS.
fn get_standard_sdk_paths() -> Vec<&'static str> {
    if cfg!(target_os = "windows") {
        vec![
            r"C:\Program Files\Cangjie",
            r"D:\Program Files\Cangjie",
            r"C:\Program Files (x86)\Cangjie",
            r"D:\Program Files (x86)\Cangjie",
        ]
    } else if cfg!(target_os = "macos") {
        vec![
            "/Applications/Cangjie.app/Contents/MacOS", // Common macOS app structure
            "/usr/local/cangjie",                       // Potential custom install
            "/opt/cangjie",                             // Another potential custom install
        ]
    } else {
        // Assume Linux-like
        vec![
            "/usr/local/cangjie", // Potential custom install
            "/opt/cangjie",       // Another potential custom install
        ]
    }
}

// --- Zed Extension API Implementation ---

impl zed::Extension for CangjieExtension {
    fn new() -> Self
    where
        Self: Sized,
    {
        CangjieExtension::new()
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Command, String> {
        let server_binary = self.language_server_binary(language_server_id, worktree)?;
        Ok(Command {
            command: server_binary.path,
            args: server_binary.arguments,
            env: server_binary.env,
        })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &LanguageServerId,
        _worktree: &Worktree,
    ) -> Result<Option<serde_json::Value>, String> {
        // If the LSP supports initialization options, configure them here.
        // For now, returning None.
        Ok(None)
    }

    // Note: language_server_workspace_configuration is no longer a trait method in 0.7.0

    fn complete_slash_command_argument(
        &self,
        _command: SlashCommand,
        _args: Vec<String>, // Changed from &[String] to Vec<String>
    ) -> Result<Vec<SlashCommandArgumentCompletion>, String> {
        // Provide completions for arguments of slash commands.
        // For our simple example, no arguments are needed, so return empty.
        Ok(vec![])
    }

    fn run_slash_command(
        &self,
        command: SlashCommand, // Changed from &SlashCommand to SlashCommand
        _args: Vec<String>,    // Changed from &[String] to Vec<String>
        _worktree: Option<&Worktree>, // Changed from &Worktree to Option<&Worktree>
    ) -> Result<SlashCommandOutput, String> {
        match command.name.as_str() {
            "cangjie-info" => {
                // Note: Worktree is now optional. We need to handle this.
                if let Some(worktree) = _worktree {
                    let mut output_lines = vec!["**Cangjie Extension Information:**\n".to_string()];
                    match self.resolve_sdk_root(worktree) {
                        Ok(root) => output_lines.push(format!("SDK Root: `{}`", root.display())),
                        Err(e) => {
                            output_lines.push(format!("SDK Root: *Error finding SDK:* {}", e))
                        }
                    }
                    match self.cjc_binary_path(worktree) {
                        Ok(path) => output_lines.push(format!("cjc Path: `{}`", path)),
                        Err(e) => output_lines.push(format!("cjc Path: *Error:* {}", e)),
                    }
                    match self.cjc_frontend_binary_path(worktree) {
                        Ok(path) => output_lines.push(format!("cjc-frontend Path: `{}`", path)),
                        Err(e) => output_lines.push(format!("cjc-frontend Path: *Error:* {}", e)),
                    }

                    Ok(SlashCommandOutput {
                        text: output_lines.join("\n"),
                        sections: vec![], // Sections can be used to highlight parts of the output
                    })
                } else {
                    // Handle case where worktree is not available
                    Ok(SlashCommandOutput {
                        text: "**Cangjie Extension Information:**\nWorktree not available for this command.".to_string(),
                        sections: vec![],
                    })
                }
            }
            _ => Err(format!(
                "Unhandled slash command execution: {}",
                command.name
            )),
        }
    }

    fn context_server_command(
        &mut self,
        _context_server_id: &zed_extension_api::ContextServerId,
        _project: &Project,
    ) -> Result<Command, String> {
        // If you have a separate context server, implement its startup command here.
        // For now, returning an error as it's not configured.
        Err("Context server not implemented for Cangjie extension".to_string())
    }

    fn context_server_configuration(
        &mut self,
        _context_server_id: &zed_extension_api::ContextServerId,
        _project: &Project,
    ) -> Result<Option<ContextServerConfiguration>, String> {
        // If you have a separate context server, implement its configuration here.
        // For now, returning None.
        Ok(None)
    }

    // Note: label_for_completion and label_for_symbol are now part of a separate trait, not Extension trait directly

    // Note: completions, code_actions, run_task, prepare_rename, perform_rename, project_settings_schema are not part of Extension trait

    // --- New methods added in 0.7.0 ---

    fn language_server_additional_initialization_options(
        &mut self,
        _language_server_id: &LanguageServerId,
        _target_language_server_id: &LanguageServerId,
        _worktree: &Worktree,
    ) -> Result<Option<serde_json::Value>, String> {
        // Not implemented for this extension.
        Ok(None)
    }

    fn language_server_additional_workspace_configuration(
        &mut self,
        _language_server_id: &LanguageServerId,
        _target_language_server_id: &LanguageServerId,
        _worktree: &Worktree,
    ) -> Result<Option<serde_json::Value>, String> {
        // Not implemented for this extension.
        Ok(None)
    }

    fn label_for_completion(
        &self,
        _language_server_id: &LanguageServerId,
        _completion: Completion,
    ) -> Option<CodeLabel> {
        // Not implemented for this extension.
        None
    }

    fn label_for_symbol(
        &self,
        _language_server_id: &LanguageServerId,
        _symbol: Symbol,
    ) -> Option<CodeLabel> {
        // Not implemented for this extension.
        None
    }

    fn suggest_docs_packages(&self, _provider: String) -> Result<Vec<String>, String> {
        // Not implemented for this extension.
        Ok(Vec::new())
    }

    fn index_docs(
        &self,
        _provider: String,
        _package: String,
        _database: &KeyValueStore,
    ) -> Result<(), String> {
        // Not implemented for this extension.
        Err("`index_docs` not implemented".to_string())
    }

    fn get_dap_binary(
        &mut self,
        _adapter_name: String,
        _config: DebugTaskDefinition,
        _user_provided_debug_adapter_path: Option<String>,
        _worktree: &Worktree,
    ) -> Result<DebugAdapterBinary, String> {
        // Not implemented for this extension.
        Err("`get_dap_binary` not implemented".to_string())
    }

    fn dap_request_kind(
        &mut self,
        _adapter_name: String,
        _config: serde_json::Value,
    ) -> Result<StartDebuggingRequestArgumentsRequest, String> {
        // Not implemented for this extension.
        Err("`dap_request_kind` not implemented".to_string())
    }

    fn dap_config_to_scenario(&mut self, _config: DebugConfig) -> Result<DebugScenario, String> {
        // Not implemented for this extension.
        Err("`dap_config_to_scenario` not implemented".to_string())
    }

    fn dap_locator_create_scenario(
        &mut self,
        _locator_name: String,
        _build_task: TaskTemplate,
        _resolved_label: String,
        _debug_adapter_name: String,
    ) -> Option<DebugScenario> {
        // Not implemented for this extension.
        None
    }

    fn run_dap_locator(
        &mut self,
        _locator_name: String,
        _build_task: TaskTemplate,
    ) -> Result<DebugRequest, String> {
        // Not implemented for this extension.
        Err("`run_dap_locator` not implemented".to_string())
    }
}

// --- Entry Point ---

zed::register_extension!(CangjieExtension);
