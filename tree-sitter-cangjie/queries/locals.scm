; Variable declarations
(variable_declaration
  (pattern
    (binding_pattern
      (identifier) @definition.var)))
(constant_declaration
  (identifier) @definition.constant)

; Function declarations
(function_declaration
  (identifier) @definition.function)

; Class and struct declarations
(class_declaration
  (identifier) @definition.class)
(struct_declaration
  (identifier) @definition.struct)
(interface_declaration
  (identifier) @definition.interface)
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
(interface_declaration
  (interface_body) @scope)
(enum_declaration
  (enum_body) @scope)
