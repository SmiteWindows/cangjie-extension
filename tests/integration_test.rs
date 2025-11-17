// tests/integration_test.rs
#[cfg(test)]
mod tests {
    use zed_extension_api as zed;

    #[test]
    fn test_extension_initialization() {
        let extension = super::CangjieExtension::new();
        assert!(extension.cached_binary_path.is_none());
    }

    #[test]
    fn test_language_name() {
        let extension = super::CangjieExtension::new();
        assert_eq!(extension.language_name(), "Cangjie");
    }

    #[test]
    fn test_file_extensions() {
        let extension = super::CangjieExtension::new();
        let extensions = extension.file_extensions();
        assert!(extensions.contains(&"cj"));
        assert!(extensions.contains(&"cangjie"));
    }
}
