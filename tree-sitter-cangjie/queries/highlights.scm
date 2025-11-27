; Keywords
; No keyword node type defined, keywords are handled as part of other rules

; Types
(primitive_type) @type.builtin
(type_identifier) @type
(generic_type
  (type_identifier) @type)

; Functions
(function_declaration
  (identifier) @function)
(call_expression
  (identifier) @function.call)
(call_expression
  (member_access_expression
    (identifier) @method.call))

; Variables
(variable_declaration
  (pattern
    (binding_pattern) @variable))

; Variable references
(identifier_expression
  (identifier) @variable.reference)
(member_access_expression
  (identifier) @property)

; Literals
(literal) @literal
(string_literal) @string
(boolean_literal) @boolean
(unit_literal) @constant
(none_literal) @constant
(nothing_literal) @constant
(rune_literal) @string.special

; Comments
(comment) @comment
