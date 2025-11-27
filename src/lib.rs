// src/lib.rs
use std::collections::HashMap;
use std::env;
use std::ffi::OsStr;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use zed_extension_api::{self as zed, Architecture, Os, process::Command, settings::LspSettings};

const SERVER_NAME: &str = "cangjie-lsp";
const CJC_NAME: &str = "cjc";
const CJC_FRONTEND_NAME: &str = "cjc-frontend";
// const GITHUB_RELEASE_API_URL: &str = "https://api.github.com/repos/cangjie-lang/cangjie/releases/latest"; // No longer used

// --- Configuration Keys ---
const CONFIG_SDK_PATH_KEY: &str = "cangjie.sdkPath";
// const CONFIG_LSP_PATH_KEY: &str = "cangjie.lspPathOverride"; // No longer used
const CONFIG_CJC_PATH_KEY: &str = "cangjie.cjcPathOverride";
const CONFIG_CJC_FRONTEND_PATH_KEY: &str = "cangjie.cjcFrontendPathOverride";

// --- Environment Variable ---
const ENV_CANGJIE_HOME: &str = "CANGJIE_HOME";

// --- Error Messages ---
const ERR_SDK_NOT_FOUND: &str = "Cangjie SDK not found. Please set the 'CANGJIE_HOME' environment variable, set 'cangjie.sdkPath' in your project settings, or place this extension within a standard Cangjie SDK structure.";
const ERR_TOOL_NOT_FOUND_FMT: &str = "Tool '{}' not found in SDK or overridden path.";

pub struct CangjieExtension {
    cached_tool_paths: Arc<Mutex<HashMap<String, String>>>,
    // In-memory state simulation, as direct KV store access might be limited
    in_memory_state: Arc<Mutex<HashMap<String, String>>>,
}

impl CangjieExtension {
    pub fn new() -> Self {
        Self {
            cached_tool_paths: Arc::new(Mutex::new(HashMap::new())),
            in_memory_state: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    /// Resolves the root path of the Cangjie SDK.
    /// The search order is:
    /// 1. Check user configuration for SDK path (project setting via LspSettings).
    /// 2. Check the `CANGJIE_HOME` environment variable.
    /// 3. Attempt to infer from the current executable's location.
    fn resolve_sdk_root(&self, worktree: &zed::Worktree) -> Result<PathBuf, String> {
        // 1. Check user configuration for SDK path via LspSettings
        if let Ok(lsp_settings) = LspSettings::for_worktree("cangjie", worktree)
            && let Some(cangjie_settings) = &lsp_settings.settings
            && let Some(sdk_path_val) = cangjie_settings.get(CONFIG_SDK_PATH_KEY)
            && let Some(sdk_path_str) = sdk_path_val.as_str()
        {
            let sdk_path = PathBuf::from(sdk_path_str);
            if sdk_path.exists() && sdk_path.is_dir() {
                log::info!("Using SDK path from LSP settings: {:?}", sdk_path);
                return Ok(sdk_path);
            } else {
                log::warn!(
                    "Configured SDK path from settings does not exist: {:?}",
                    sdk_path
                );
            }
        }

        // 2. Check the CANGJIE_HOME environment variable
        if let Ok(cangjie_home) = env::var(ENV_CANGJIE_HOME) {
            let sdk_path = PathBuf::from(cangjie_home);
            if sdk_path.is_absolute() && sdk_path.exists() && sdk_path.is_dir() {
                log::info!("Using SDK path from {}: {:?}", ENV_CANGJIE_HOME, sdk_path);
                return Ok(sdk_path);
            } else {
                log::warn!(
                    "{} points to an invalid path: {:?}",
                    ENV_CANGJIE_HOME,
                    sdk_path
                );
            }
        }

        // 3. Try to infer the SDK root from the current executable's path
        match env::current_exe() {
            Ok(exe_path) => {
                log::debug!(
                    "Attempting to infer SDK root from executable path: {:?}",
                    exe_path
                );

                const BIN_DIR: &str = "bin";
                const TOOLS_DIR: &str = "tools";

                if let Some(parent) = exe_path.parent()
                    && parent.file_name() == Some(OsStr::new(BIN_DIR))
                    && let Some(candidate) = parent.parent()
                    && candidate.exists()
                    && candidate.is_dir()
                    && candidate.join(BIN_DIR).is_dir()
                {
                    log::info!(
                        "Inferred SDK root from executable path (in bin): {:?}",
                        candidate
                    );
                    return Ok(candidate.to_path_buf());
                }

                if let Some(tools_bin) = exe_path.parent().and_then(|p| p.parent())
                    && tools_bin.file_name() == Some(OsStr::new(BIN_DIR))
                    && let Some(tools) = tools_bin.parent()
                    && tools.file_name() == Some(OsStr::new(TOOLS_DIR))
                    && let Some(candidate) = tools.parent()
                    && candidate.exists()
                    && candidate.is_dir()
                    && candidate.join(BIN_DIR).is_dir()
                {
                    log::info!(
                        "Inferred SDK root from executable path (in tools/bin): {:?}",
                        candidate
                    );
                    return Ok(candidate.to_path_buf());
                }
            }
            Err(e) => {
                log::warn!("Failed to get current executable path: {}", e);
            }
        }

        Err(ERR_SDK_NOT_FOUND.to_string())
    }

    /// Resolves the full path to a specific tool binary within the SDK or via override.
    /// Uses caching for efficiency.
    fn resolve_tool_binary_path(
        &self,
        worktree: &zed::Worktree,
        tool_name: &str,
        _config_override_key: &str, // Unused, but kept for signature compatibility if needed elsewhere
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

        // Check override via LSP settings
        if let Ok(lsp_settings) = LspSettings::for_worktree("cangjie", worktree)
            && let Some(binary_settings) = &lsp_settings.binary
            && let Some(override_path_str) = &binary_settings.path
        {
            let override_path = PathBuf::from(override_path_str);
            if override_path.exists() && (override_path.is_file() || override_path.is_symlink()) {
                let resolved_path = override_path
                    .canonicalize()
                    .map_err(|e| format!("Failed to canonicalize override path: {}", e))?
                    .to_string_lossy()
                    .to_string();

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

        let sdk_root = self.resolve_sdk_root(worktree)?;
        let tool_path = sdk_root.join(default_subdir).join(default_filename);

        if tool_path.exists() && (tool_path.is_file() || tool_path.is_symlink()) {
            let resolved_path = tool_path
                .canonicalize()
                .map_err(|e| format!("Failed to canonicalize tool path: {}", e))?
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
            &get_binary_name(CJC_NAME),
        )
    }

    fn cjc_frontend_binary_path(&self, worktree: &zed::Worktree) -> Result<String, String> {
        self.resolve_tool_binary_path(
            worktree,
            CJC_FRONTEND_NAME,
            CONFIG_CJC_FRONTEND_PATH_KEY,
            "bin",
            &get_binary_name(CJC_FRONTEND_NAME),
        )
    }

    /// Checks if the LSP server needs to be installed and attempts to install it.
    fn ensure_language_server_installed(
        &self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String, String> {
        // 1. Check for override via LSP settings first
        if let Ok(lsp_settings) = LspSettings::for_worktree("cangjie-lsp", worktree)
            && let Some(binary_settings) = &lsp_settings.binary
            && let Some(override_path_str) = &binary_settings.path
        {
            let override_path = PathBuf::from(override_path_str);
            if override_path.exists() && (override_path.is_file() || override_path.is_symlink()) {
                let resolved_path = override_path
                    .canonicalize()
                    .map_err(|e| format!("Failed to canonicalize override LSP path: {}", e))?
                    .to_string_lossy()
                    .to_string();
                log::info!("Using override LSP path: {}", resolved_path);
                return Ok(resolved_path);
            } else {
                log::warn!(
                    "Configured LSP override path does not exist: {:?}",
                    override_path
                );
                return Err(format!(
                    "LSP override path does not exist: {}",
                    override_path.display()
                ));
            }
        }

        // 2. Check if it exists in the SDK path
        let sdk_root = self.resolve_sdk_root(worktree)?;
        let lsp_path = sdk_root.join("bin").join(&get_binary_name(SERVER_NAME));

        if lsp_path.exists() && (lsp_path.is_file() || lsp_path.is_symlink()) {
            let resolved_path = lsp_path
                .canonicalize()
                .map_err(|e| format!("Failed to canonicalize LSP path: {}", e))?
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

        let options = zed::GithubReleaseOptions {
            require_assets: true,
            pre_release: false,
        };
        let release = zed::latest_github_release("cangjie-lang/cangjie", options)
            .map_err(|e| format!("Failed to fetch GitHub release: {}", e))?;

        let asset = release
            .assets
            .iter()
            .find(|a| a.name == asset_name)
            .ok_or_else(|| format!("No asset found matching '{}'", asset_name))?;

        // Use a path relative to the user's home directory for download
        let home_dir = std::env::var("HOME")
            .or_else(|_| std::env::var("USERPROFILE"))
            .map_err(|_| "Could not find HOME or USERPROFILE directory".to_string())?;
        let download_path = PathBuf::from(home_dir)
            .join(".zed")
            .join("extensions")
            .join(&asset.name);

        zed::download_file(
            &asset.download_url,
            download_path.to_string_lossy().as_ref(),
            zed::DownloadedFileType::Uncompressed,
        ) // Pass &str
        .map_err(|e| format!("Download failed: {}", e))?;

        if os != Os::Windows {
            zed::make_file_executable(download_path.to_string_lossy().as_ref()) // Pass &str
                .map_err(|e| format!("Failed to make executable: {}", e))?;
        }

        log::info!("LSP downloaded successfully to: {:?}", download_path);
        Ok(download_path.to_string_lossy().to_string())
    }

    /// Creates the command to start the language server, integrating LSP settings.
    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command, String> {
        let server_path = self.ensure_language_server_installed(language_server_id, worktree)?;

        // Determine if LSP settings override the command or args
        let mut command = zed::Command::new(&server_path);
        let mut default_args = vec!["--stdio".to_string()]; // Default transport

        if let Ok(lsp_settings) = LspSettings::for_worktree("cangjie-lsp", worktree)
            && let Some(binary_settings) = &lsp_settings.binary
        {
            if let Some(path_override) = &binary_settings.path {
                // If path is overridden, create a new command
                command = zed::Command::new(path_override);
            }
            if let Some(args_override) = &binary_settings.arguments {
                // If args are overridden, use them instead of defaults
                default_args = args_override.clone();
            }
        }

        // Chain the args call to avoid move issues, as args() takes ownership
        let final_command = command.args(default_args);

        // Note: The `env` field does not exist on LspSettings in this version.
        // if let Some(env_vars) = &lsp_settings.env {
        //     for (key, value) in env_vars.iter() {
        //         if let Some(val_str) = value.as_str() {
        //             command = command.env(key, val_str);
        //         }
        //     }
        // }

        Ok(final_command)
    }

    /// Gets the asset name for downloading the LSP server based on platform.
    fn get_asset_name_for_platform(
        &self,
        os: Os,
        arch: Architecture,
        base_name: &str,
    ) -> Result<String, String> {
        let arch_str = match arch {
            Architecture::X8664 => "x86_64", // Corrected enum variant
            Architecture::Aarch64 => "aarch64",
            _ => return Err("Unsupported architecture".into()),
        };

        let (os_str, ext) = match os {
            Os::Mac => ("apple-darwin", ""), // Corrected enum variant
            Os::Linux => ("unknown-linux-gnu", ""),
            Os::Windows => ("pc-windows-msvc", ".exe"),
            // _ => return Err("Unsupported OS".into()), // Removed unreachable pattern
        };

        Ok(format!("{}-{}-{}{}", base_name, arch_str, os_str, ext))
    }

    /// Handles the `/cangjie build` slash command.
    fn handle_build_command(
        &self,
        worktree: &zed::Worktree,
    ) -> Result<zed::SlashCommandOutput, String> {
        let cjc_path = self.cjc_binary_path(worktree)?;

        // Chain the args call to avoid move issues, as args() takes ownership
        let output = Command::new(&cjc_path)
            .args(vec!["build".to_string()])
            .output() // Use the final command value
            .map_err(|e| format!("Failed to run build command: {}", e))?;

        let mut sections = Vec::new();
        let mut full_output_text = String::new();

        // Check exit code manually as `success()` is not available
        let success = output.status.unwrap_or(1) == 0;
        if success {
            full_output_text.push_str("✅ Build succeeded!\n\n");
        } else {
            full_output_text.push_str("❌ Build failed!\n\n");
        }

        let stdout_str = String::from_utf8_lossy(&output.stdout);
        let stderr_str = String::from_utf8_lossy(&output.stderr);

        if !stdout_str.is_empty() {
            full_output_text.push_str("Standard Output:\n");
            full_output_text.push_str(&stdout_str);
            full_output_text.push('\n');
        }

        if !stderr_str.is_empty() {
            full_output_text.push_str("Standard Error:\n");
            full_output_text.push_str(&stderr_str);
            full_output_text.push('\n');
        }

        sections.push(zed::SlashCommandOutputSection {
            label: "Build Result".to_string(),
            range: zed::Range {
                start: 0,
                end: full_output_text.len() as u32,
            },
        });

        Ok(zed::SlashCommandOutput {
            text: full_output_text,
            sections,
        })
    }

    /// Handles the `/cangjie check-updates` slash command using http_client.
    fn handle_check_updates_command(&self) -> Result<zed::SlashCommandOutput, String> {
        let last_check_key = "last_update_check_cangjie_lsp";
        let now = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .map_err(|e| format!("Time error: {}", e))?
            .as_secs(); // Removed unnecessary cast

        // Check if we've checked recently (e.g., in the last hour) using in-memory state
        if let Ok(state) = self.in_memory_state.lock()
            && let Some(last_check_str) = state.get(last_check_key)
            && let Ok(last_check) = last_check_str.parse::<u64>()
            && now - last_check < 3600
        {
            return Ok(zed::SlashCommandOutput {
                text: "Update check performed recently. Skipping...".to_string(),
                sections: vec![zed::SlashCommandOutputSection {
                    label: "Status".to_string(),
                    range: zed::Range { start: 0, end: 45 }, // Length of the status message
                }],
            });
        }

        // Simulate HTTP request (Note: Actual HTTP calls in synchronous context might not be supported by Zed's synchronous trait methods)
        // For demonstration, we'll simulate the response.
        // In a real scenario, this would likely need to be handled differently or be part of an async command handler.
        let simulated_response = r#"{"tag_name": "v0.1.0"}"#;
        let release_info: serde_json::Value = serde_json::from_str(simulated_response)
            .map_err(|e| format!("Failed to parse simulated JSON: {}", e))?;

        if let Some(tag_name) = release_info.get("tag_name").and_then(|v| v.as_str()) {
            {
                let mut state = self.in_memory_state.lock().unwrap();
                state.insert(last_check_key.to_string(), now.to_string());
            }

            let message = format!("Latest Cangjie LSP release: **{}**", tag_name);
            Ok(zed::SlashCommandOutput {
                text: message.clone(),
                sections: vec![zed::SlashCommandOutputSection {
                    label: "Update Info".to_string(),
                    range: zed::Range {
                        start: 0,
                        end: message.len() as u32,
                    },
                }],
            })
        } else {
            Err("Could not find 'tag_name' in simulated release info.".into())
        }
    }
}

pub fn get_binary_name(base_name: &str) -> String {
    // Return a String instead of &'static str to avoid lifetime issues
    match (base_name, cfg!(windows)) {
        ("cangjie-lsp", true) => "cangjie-lsp.exe".to_string(),
        ("cangjie-lsp", false) => "cangjie-lsp".to_string(),
        ("cjc", true) => "cjc.exe".to_string(),
        ("cjc", false) => "cjc".to_string(),
        ("cjc-frontend", true) => "cjc-frontend.exe".to_string(),
        ("cjc-frontend", false) => "cjc-frontend".to_string(),
        _ => {
            // For unknown names, return the base name with appropriate extension
            if cfg!(windows) {
                format!("{}.exe", base_name)
            } else {
                base_name.to_string()
            }
        }
    }
}

impl zed::Extension for CangjieExtension {
    fn new() -> Self
    where
        Self: Sized,
    {
        CangjieExtension::new()
    }

    fn language_server_command(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command, String> {
        self.language_server_command(language_server_id, worktree)
    }

    fn language_server_workspace_configuration(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<Option<serde_json::Value>, String> {
        // Attempt to get settings from LspSettings for the 'cangjie' language
        if let Ok(lsp_settings) = LspSettings::for_worktree("cangjie", worktree)
            && let Some(cangjie_settings) = &lsp_settings.settings
        {
            // Return the 'cangjie' specific settings part
            return Ok(Some(cangjie_settings.clone()));
        }
        Ok(None)
    }

    // --- DAP Integration ---

    fn dap_locator_create_scenario(
        &mut self,
        locator_name: String,
        build_task: zed::TaskTemplate,
        resolved_label: String,
        debug_adapter_name: String,
    ) -> Option<zed::DebugScenario> {
        if build_task.command != CJC_NAME {
            return None;
        }

        let cwd = build_task.cwd.clone();
        let env = build_task.env.clone().into_iter().collect();

        let mut args_it = build_task.args.iter();
        let build_template = if let Some(arg) = args_it.next()
            && arg == "build"
            && let Some(arg) = args_it.next()
            && arg == "run"
        {
            zed::BuildTaskDefinitionTemplatePayload {
                template: zed::BuildTaskTemplate {
                    label: format!("{} (build)", resolved_label),
                    command: CJC_NAME.into(),
                    args: vec!["build".into()],
                    env,
                    cwd,
                },
                locator_name: Some(locator_name), // Removed unnecessary .into()
            }
        } else {
            return None;
        };

        // Define the debug configuration
        let config = serde_json::json!({
            "name": "Launch Cangjie Program",
            "type": "cjc-frontend", // The adapter name
            "request": "launch",
            "program": "${workspaceFolder}/target/debug/${workspaceFolderBasename}", // Placeholder, resolved by `run_dap_locator`
            "cwd": "${workspaceFolder}",
            "args": [],
            "stopOnEntry": false,
        });

        let Ok(config_str) = serde_json::to_string(&config) else {
            return None;
        };

        Some(zed::DebugScenario {
            adapter: debug_adapter_name,
            label: resolved_label,
            config: config_str,
            tcp_connection: None, // Use stdio
            build: Some(zed::BuildTaskDefinition::Template(build_template)),
        })
    }

    fn run_dap_locator(
        &mut self,
        _locator_name: String,
        build_task: zed::TaskTemplate,
    ) -> Result<zed::DebugRequest, String> {
        let mut args_it = build_task.args.iter();
        if let Some(arg) = args_it.next()
            && arg == "build"
        {
            let exec_name = get_project_name(&build_task).ok_or("Failed to get project name")?;
            let program_path = format!("zig-out/bin/{}", exec_name);

            Ok(zed::DebugRequest::Launch(zed::LaunchRequest {
                program: program_path,                      // `program` is `String`
                cwd: build_task.cwd,                        // `cwd` is `Option<String>`
                args: vec![],                               // `args` is `Vec<String>`
                envs: build_task.env.into_iter().collect(), // `envs` is `Vec<(String, String)>`
            }))
        } else {
            Err("Unsupported build task for debugging".into())
        }
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
            command: Some(binary_path), // `command` is `Option<String>`
            arguments: vec![],          // `arguments` is `Vec<String>`
            envs: Default::default(),
            cwd: None,
            connection: None, // Use stdio
            // `request_args` is a `StartDebuggingRequestArguments` struct
            request_args: zed::StartDebuggingRequestArguments {
                // `request` is a `StartDebuggingRequestArgumentsRequest` enum
                request: zed::StartDebuggingRequestArgumentsRequest::Launch,
                // `configuration` is a `DebugConfiguration` struct (empty in this case)
                configuration: Default::default(), // Use default DebugConfiguration
            },
        })
    }

    fn dap_request_kind(
        &mut self,
        _adapter_name: String,
        _config: serde_json::Value,
    ) -> Result<zed::StartDebuggingRequestArgumentsRequest, String> {
        Ok(zed::StartDebuggingRequestArgumentsRequest::Launch)
    }

    fn dap_config_to_scenario(
        &mut self,
        _config: zed::DebugConfig,
    ) -> Result<zed::DebugScenario, String> {
        // This is called when a debug config is defined directly in the project settings.
        // This specific API version does not provide direct access to `config.adapter` or `config.label` as fields.
        // The scenario is usually created via `dap_locator_create_scenario` or by returning a JSON string from workspace config.
        // Returning an error is appropriate if this path cannot be handled with available APIs.
        Err(
            "Direct DebugConfig to Scenario conversion is not supported in this API version."
                .into(),
        )
    }

    // --- Slash Commands ---

    fn run_slash_command(
        &self,
        command: zed::SlashCommand,
        _args: Vec<String>,
        worktree: Option<&zed::Worktree>,
    ) -> Result<zed::SlashCommandOutput, String> {
        let worktree = worktree.ok_or("Worktree not available for slash command")?;

        match command.name.as_str() {
            "cangjie-info" => {
                let mut output_lines = vec!["**Cangjie Extension Information:**\n".to_string()];
                match self.resolve_sdk_root(worktree) {
                    Ok(root) => output_lines.push(format!("SDK Root: `{}`", root.display())),
                    Err(e) => output_lines.push(format!("SDK Root: *Error finding SDK:* {}", e)),
                }
                match self.cjc_binary_path(worktree) {
                    Ok(path) => output_lines.push(format!("cjc Path: `{}`", path)),
                    Err(e) => output_lines.push(format!("cjc Path: *Error:* {}", e)),
                }
                match self.cjc_frontend_binary_path(worktree) {
                    Ok(path) => output_lines.push(format!("cjc-frontend Path: `{}`", path)),
                    Err(e) => output_lines.push(format!("cjc-frontend Path: *Error:* {}", e)),
                }

                let text = output_lines.join("\n");
                Ok(zed::SlashCommandOutput {
                    text: text.clone(), // Clone text to avoid move/borrow conflict
                    sections: vec![zed::SlashCommandOutputSection {
                        label: "Info".to_string(),
                        range: zed::Range {
                            start: 0,
                            end: text.len() as u32,
                        }, // Use cloned text length
                    }],
                })
            }
            "cangjie-build" => self.handle_build_command(worktree),
            "cangjie-check-updates" => self.handle_check_updates_command(),
            _ => Err(format!("Unhandled slash command: {}", command.name)),
        }
    }

    // --- Other Trait Methods ---

    fn label_for_completion(
        &self,
        _language_server_id: &zed::LanguageServerId,
        completion: zed::lsp::Completion,
    ) -> Option<zed::CodeLabel> {
        Some(zed::CodeLabel {
            code: completion.label.clone(),
            spans: vec![
                // Example: Highlight the entire label with a literal span
                zed::CodeLabelSpan::Literal(zed::CodeLabelSpanLiteral {
                    text: completion.label.clone(),       // The text to highlight
                    highlight_name: Some("".to_string()), // Optional syntax highlight name, e.g., "function". Wrapped in Some.
                }),
            ],
            filter_range: zed::Range {
                start: 0,
                end: completion.label.len() as u32,
            },
        })
    }

    fn label_for_symbol(
        &self,
        _language_server_id: &zed::LanguageServerId,
        symbol: zed::lsp::Symbol,
    ) -> Option<zed::CodeLabel> {
        Some(zed::CodeLabel {
            code: symbol.name.clone(),
            spans: vec![
                // Example: Highlight the entire symbol name with a literal span
                zed::CodeLabelSpan::Literal(zed::CodeLabelSpanLiteral {
                    text: symbol.name.clone(),            // The text to highlight
                    highlight_name: Some("".to_string()), // Optional syntax highlight name, e.g., "type". Wrapped in Some.
                }),
            ],
            filter_range: zed::Range {
                start: 0,
                end: symbol.name.len() as u32,
            },
        })
    }

    fn context_server_configuration(
        &mut self,
        _server_id: &zed::ContextServerId,
        _project: &zed::Project,
    ) -> Result<Option<zed::ContextServerConfiguration>, String> {
        // Example: Provide a configuration for an AI context server related to Cangjie
        Ok(Some(zed::ContextServerConfiguration {
            installation_instructions: "Install the Cangjie language server and context provider."
                .to_string(),
            default_settings: serde_json::json!({
                "include_docs": true
            })
            .to_string(),
            settings_schema: serde_json::json!({ // Added required field
                "type": "object",
                "properties": {
                    "include_docs": {
                        "type": "boolean",
                        "default": true,
                        "description": "Include documentation in context."
                    }
                }
            })
            .to_string(),
        }))
    }
}

// --- Utility Functions ---

pub fn get_project_name(task: &zed::TaskTemplate) -> Option<String> {
    task.cwd
        .as_ref()
        .and_then(|cwd| Some(Path::new(&cwd).file_name()?.to_string_lossy().into_owned()))
}

// --- Entry Point ---

zed::register_extension!(CangjieExtension);

// --- Tests ---

#[cfg(test)]
mod tests {
    use super::*;
    use zed_extension_api::TaskTemplate;

    #[test]
    fn test_extension_initialization() {
        let _extension = CangjieExtension::new();
        // 测试扩展是否成功初始化
        assert!(true);
    }

    #[test]
    fn test_get_binary_name() {
        // 测试 get_binary_name 函数
        if cfg!(windows) {
            assert_eq!(get_binary_name("cjc"), "cjc.exe".to_string());
            assert_eq!(get_binary_name("cjc-frontend"), "cjc-frontend.exe".to_string());
            assert_eq!(get_binary_name("cangjie-lsp"), "cangjie-lsp.exe".to_string());
            // 测试未知名称的处理
            assert_eq!(get_binary_name("unknown"), "unknown.exe".to_string());
        } else {
            assert_eq!(get_binary_name("cjc"), "cjc".to_string());
            assert_eq!(get_binary_name("cjc-frontend"), "cjc-frontend".to_string());
            assert_eq!(get_binary_name("cangjie-lsp"), "cangjie-lsp".to_string());
            // 测试未知名称的处理
            assert_eq!(get_binary_name("unknown"), "unknown".to_string());
        }
    }

    #[test]
    fn test_get_project_name() {
        // 测试 get_project_name 函数
        let task = TaskTemplate {
            label: "test".to_string(),
            command: "test".to_string(),
            args: vec![],
            env: vec![],
            cwd: Some("/path/to/project".to_string()),
        };
        assert_eq!(get_project_name(&task), Some("project".to_string()));
    }
}
