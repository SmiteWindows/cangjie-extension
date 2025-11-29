
# Configuration

## Extension Settings

The Cangjie extension provides several configuration options to customize its behavior:

### Language Server Settings

- `enableSemanticHighlighting`: Enable semantic syntax highlighting for better code readability (default: true)
- `maxFileSize`: Maximum file size in bytes for language server processing (default: 1000000)
- `checkOnSave`: Enable checking on file save (default: true)
- `sdkPath`: Path to the Cangjie SDK installation directory (default: auto-detected)

### Editor Settings

The extension uses the following editor settings by default:

- **Indentation**: 4 spaces
- **Tabs**: Soft tabs
- **Line Comments**: `// `
- **Block Comments**: `/* */`
- **Brackets**: Auto-closing brackets with newline for `{}`

### Debug Adapter Settings

- `stopOnEntry`: Whether to stop at the first line of the program when debugging (default: false)
- `program`: Path to the program to debug (default: `${workspaceFolder}/target/debug/${workspaceFolderBasename}`)
- `cwd`: Working directory for the debug session (default: `${workspaceFolder}`)

## Configuration Example

```json
{
  "cangjie": {
    "enableSemanticHighlighting": true,
    "maxFileSize": 2000000,
    "checkOnSave": true,
    "sdkPath": "/opt/cangjie-sdk"
  }
}
```

## Environment Variables

The extension respects the following environment variables:

- `CANGJIE_HOME`: Path to the Cangjie SDK installation directory
- `CANGJIE_LOG_LEVEL`: Log level for the language server (default: info)

## Advanced Settings

For advanced users, the extension also supports configuring the language server directly through LSP settings. Refer to the Cangjie Language Server documentation for more details.
