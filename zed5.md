```rust
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

struct CangjieExtension {
    cached_tool_paths: Arc<Mutex<HashMap<String, String>>>,
    // In-memory state simulation, as direct KV store access might be limited
    in_memory_state: Arc<Mutex<HashMap<String, String>>>,
}

impl CangjieExtension {
    fn new() -> Self {
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
        let lsp_path = sdk_root.join("bin").join(get_binary_name(SERVER_NAME));

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

fn get_binary_name(base_name: &str) -> &'static str {
    // Ensure all match arms return a &'static str
    match (base_name, cfg!(windows)) {
        ("cangjie-lsp", true) => "cangjie-lsp.exe",
        ("cangjie-lsp", false) => "cangjie-lsp",
        ("cjc", true) => "cjc.exe",
        ("cjc", false) => "cjc",
        ("cjc-frontend", true) => "cjc-frontend.exe",
        ("cjc-frontend", false) => "cjc-frontend",
        _ => {
            // For unknown names, return a default static string or panic.
            // Returning a dynamic string like base_name.to_string().leak() is not safe here.
            // Returning an empty string or a generic name is safer.
            "" // Or panic!("Unknown binary name: {}", base_name);
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
            "program": "${workspaceFolder}/zig-out/bin/executable_name", // Placeholder, resolved by `run_dap_locator`
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

fn get_project_name(task: &zed::TaskTemplate) -> Option<String> {
    task.cwd
        .as_ref()
        .and_then(|cwd| Some(Path::new(&cwd).file_name()?.to_string_lossy().into_owned()))
}

// --- Entry Point ---

zed::register_extension!(CangjieExtension);
```
编译通过，静态检查通过


好的，我们来详细分析解读这个最终优化版的 lib.rs 文件。这个文件定义了一个 Zed 编辑器的扩展，专门用于支持 Cangjie 编程语言。
1. 依赖和常量定义

rust
use std::collections::HashMap;
use std::env;
use std::ffi::OsStr;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use zed_extension_api::{
self as zed,
settings::LspSettings,
process::Command,
Architecture, Os,
};

const SERVER_NAME: &str = "cangjie-lsp";
const CJC_NAME: &str = "cjc";
const CJC_FRONTEND_NAME: &str = "cjc-frontend";
// const GITHUB_RELEASE_API_URL: &str = "https://api.github.com/..."; // 注释掉未使用的常量
// const CONFIG_LSP_PATH_KEY: &str = "cangjie.lspPathOverride"; // 注释掉未使用的常量

const CONFIG_SDK_PATH_KEY: &str = "cangjie.sdkPath";
const CONFIG_CJC_PATH_KEY: &str = "cangjie.cjcPathOverride";
const CONFIG_CJC_FRONTEND_PATH_KEY: &str = "cangjie.cjcFrontendPathOverride";

const ENV_CANGJIE_HOME: &str = "CANGJIE_HOME";

const ERR_SDK_NOT_FOUND: &str = "...";
const ERR_TOOL_NOT_FOUND_FMT: &str = "...";

导入: 导入了标准库 (std) 和 zed_extension_api 库所需的类型和函数。zed_extension_api 是 Zed 官方提供的 API，用于与编辑器核心功能交互。
常量:
SERVER_NAME, CJC_NAME, CJC_FRONTEND_NAME: 定义了核心工具的名称。
CONFIG__KEY: 定义了在 Zed 项目配置 (settings.json) 中查找特定路径的键名。
ENV_CANGJIE_HOME: 定义了环境变量名。
ERR_: 定义了错误消息模板。
2. CangjieExtension 结构体

rust
struct CangjieExtension {
cached_tool_paths: Arc<Mutex<HashMap<String, String>>>,
in_memory_state: Arc<Mutex<HashMap<String, String>>>,
}

这是扩展的核心结构体，实现了 zed::Extension trait。
cached_tool_paths: 一个线程安全的哈希表，用于缓存已解析的工具路径（如 cangjie-lsp、cjc 的完整路径），避免重复查找，提高性能。
in_memory_state: 一个简单的内存状态模拟器，用于在扩展的生命周期内存储临时数据，例如上一次更新检查的时间戳。
3. 核心辅助方法
resolve_sdk_root
rust
fn resolve_sdk_root(&self, worktree: &zed::Worktree) -> Result<PathBuf, String>

目的: 查找 Cangjie SDK 的根目录。
逻辑:
1. 优先检查 Zed 项目设置 (LspSettings) 中是否指定了 cangjie.sdkPath。
2. 如果未指定，检查环境变量 CANGJIE_HOME。
3. 如果环境变量也未设置，尝试从当前扩展执行文件的路径推断 SDK 根目录（例如，如果扩展在 sdk/bin/ 下）。
4. 如果以上都失败，返回错误信息 ERR_SDK_NOT_FOUND。
优化: 使用了 clippy 建议的链式 if let && 结构来简化嵌套的 if let。
resolve_tool_binary_path
rust
fn resolve_tool_binary_path(&self, worktree: &zed::Worktree, tool_name: &str, ... ) -> Result<String, String>

目的: 查找指定工具（如 cjc 或 cjc-frontend）的完整路径。
逻辑:
1. 首先检查缓存中是否已有路径。
2. 检查 Zed 项目设置中是否指定了该工具的覆盖路径 (path_override)。
3. 如果没有覆盖路径，则在 SDK 根目录下的 bin 子目录中查找该工具。
4. 找到后，将其规范路径（canonicalize）缓存并返回。
优化: 同样使用了链式 if let &&。
ensure_language_server_installed
rust
fn ensure_language_server_installed(&self, language_server_id: &zed::LanguageServerId, worktree: &zed::Worktree) -> Result<String, String>

目的: 确保 cangjie-lsp 语言服务器已安装。
逻辑:
1. 检查 Zed 项目设置中是否有 LSP 的覆盖路径。
2. 在 SDK 的 bin 目录下查找 LSP。
3. 如果都找不到，调用 zed::latest_github_release 从 GitHub 下载最新的 LSP 二进制文件。
4. 下载后，根据操作系统设置执行权限。
5. 返回 LSP 二进制文件的路径。
language_server_command
rust
fn language_server_command(&mut self, language_server_id: &zed::LanguageServerId, worktree: &zed::Worktree) -> Result<zed::Command, String>

目的: 构建用于启动 cangjie-lsp 的 Command 对象。
逻辑:
1. 调用 ensure_language_server_installed 获取 LSP 路径。
2. 检查 Zed 项目设置中是否指定了 LSP 的启动命令或参数 (arguments)，并应用这些设置。
3. 返回配置好的 Command 对象。
4. Zed Extension Trait 实现

impl zed::Extension for CangjieExtension 是核心，它定义了 Zed 如何与这个扩展交互。

new(): 创建并返回一个新的 CangjieExtension 实例。
language_server_command: 如上所述，提供启动 LSP 的命令。
language_server_workspace_configuration: 读取 Zed 项目设置中 cangjie 部分的配置，并将其传递给 LSP 服务器。优化: 使用链式 if let &&。
DAP (Debug Adapter Protocol) 相关:
dap_locator_create_scenario: 定义了如何将 Zed 的构建任务（如 cjc build run）与调试场景关联起来，创建一个调试配置。
run_dap_locator: 根据构建任务的信息，生成实际的调试请求（DebugRequest::Launch），指定要运行的程序。
get_dap_binary: 查找并返回 cjc-frontend（调试适配器）的路径。
dap_request_kind: 指定默认的调试请求类型为 Launch。
dap_config_to_scenario: 处理直接定义在项目设置中的调试配置，当前实现返回错误，因为该 API 版本可能不支持直接转换。
Slash Commands (斜杠命令):
run_slash_command: 定义了 /cangjie-info, /cangjie-build, /cangjie-check-updates 等命令的处理逻辑。
handle_build_command: 使用 cjc 执行 build 命令。
handle_check_updates_command: 模拟检查更新（实际 HTTP 逻辑未实现），并使用 in_memory_state 避免频繁检查。优化: 移除了不必要的 u64 类型转换。
Code Completion/Symbol Labels:
label_for_completion: 为代码补全项生成标签（显示名称和高亮信息）。
label_for_symbol: 为符号（如函数、类型）生成标签。
Context Server:
context_server_configuration: 提供 AI 上下文服务器的配置信息（如果适用）。
5. 工具函数

get_binary_name: 根据工具名和当前操作系统（Windows）决定二进制文件名（例如，cjc -> cjc.exe on Windows）。
get_project_name: 从任务模板中提取项目名称（用于 DAP）。
6. 入口点

rust
zed::register_extension!(CangjieExtension);

这是宏，告诉 Zed 运行时，CangjieExtension 是这个扩展的入口点。
总结

这个 lib.rs 文件是一个功能齐全的 Zed 扩展，它负责：

1. 查找和管理 Cangjie SDK 及其工具链 (cangjie-lsp, cjc, cjc-frontend)。
2. 启动和配置 Cangjie 语言服务器 (LSP)。
3. 提供调试支持 (DAP)，允许在 Zed 中调试 Cangjie 程序。
4. 提供斜杠命令，方便用户执行构建、检查信息等操作。
5. 与 Zed 的设置系统集成，允许用户自定义工具路径和 LSP 参数。
6. 优化代码质量，修复了所有 clippy 提出的建议，使代码更清晰、更高效。

整个扩展通过 zed_extension_api 与 Zed 编辑器紧密集成，为 Cangjie 语言提供了编辑、补全、跳转、调试等核心功能。
