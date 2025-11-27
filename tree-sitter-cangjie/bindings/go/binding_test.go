package tree_sitter_yes_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_yes "github.com/smitewindows/cangjie-extension/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_yes.Language())
	if language == nil {
		t.Errorf("Error loading yes grammar")
	}
}
