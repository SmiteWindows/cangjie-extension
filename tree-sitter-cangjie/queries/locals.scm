; Variable declarations
(variable_declaration
  (pattern
    (binding_pattern
      (identifier) @definition.var)))

; Function declarations
(function_declaration
  (identifier) @definition.function)

; Class and struct declarations
(class_declaration
  (identifier) @definition.class)
(struct_declaration
  (identifier) @definition.struct)
(enum_declaration
  (identifier) @definition.enum)

; Type aliases
(type_alias_declaration
  (identifier) @definition.type)

; Variable references
(identifier_expression
  (identifier) @reference)
(member_access_expression
  (identifier) @reference)

; Scopes
(block) @scope
(function_declaration
  (block) @scope)
(class_declaration
  (class_body) @scope)
(struct_declaration
  (struct_body) @scope)
(enum_declaration
  (enum_body) @scope)
