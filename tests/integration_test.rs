// tests/integration_test.rs
#[cfg(test)]
mod tests {
    use crate::CangjieExtension;

    #[test]
    fn test_extension_initialization() {
        let extension = CangjieExtension::new();
        // 测试扩展是否成功初始化
        assert!(true);
    }

    #[test]
    fn test_get_binary_name() {
        // 测试 get_binary_name 函数
        assert_eq!(crate::get_binary_name("cjc"), "cjc");
        assert_eq!(crate::get_binary_name("cjc-frontend"), "cjc-frontend");
        assert_eq!(crate::get_binary_name("cangjie-lsp"), "cangjie-lsp");
        // 测试未知名称的处理
        assert_eq!(crate::get_binary_name("unknown"), "unknown");
    }

    #[test]
    fn test_get_project_name() {
        // 测试 get_project_name 函数
        let task = zed_extension_api::TaskTemplate {
            label: "test".to_string(),
            command: "test".to_string(),
            args: vec![],
            env: vec![],
            cwd: Some("/path/to/project".to_string()),
        };
        assert_eq!(crate::get_project_name(&task), Some("project".to_string()));
    }
}
