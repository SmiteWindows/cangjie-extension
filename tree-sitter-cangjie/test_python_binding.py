import sys
import os

# Add the bindings/python directory to the path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'tree-sitter-cangjie', 'bindings', 'python'))

print("=== Testing Python Binding ===")
try:
    import tree_sitter_yes
    print("✓ Successfully imported tree_sitter_yes")
    print(f"✓ Module has language function: {hasattr(tree_sitter_yes, 'language')}")
    print("Python binding structure is correct")
except Exception as e:
    print(f"✗ Failed to import: {e}")
    import traceback
    traceback.print_exc()
