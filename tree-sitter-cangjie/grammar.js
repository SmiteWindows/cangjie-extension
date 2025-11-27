// Define helper functions
const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));

module.exports = grammar({
  name: 'cangjie',
  extras: $ => [
    $.comment,
    /\s+/,
  ],
  conflicts: $ => [
    [$.expression, $.member_access_expression, $.call_expression, $.index_access_expression, $.unary_expression],
    [$.expression, $.member_access_expression, $.unary_expression],
    [$.expression, $.unary_expression],
    [$.expression, $.call_expression, $.unary_expression],
    [$.expression, $.index_access_expression, $.unary_expression],
    [$.expression, $.exponentiation_expression],
    [$.expression, $.multiplicative_expression],
    [$.expression, $.additive_expression],
    [$.expression, $.bitwise_shift_expression],
    [$.expression, $.relational_expression],
    [$.expression, $.equality_expression],
    [$.expression, $.bitwise_and_expression],
    [$.expression, $.bitwise_xor_expression],
    [$.expression, $.bitwise_or_expression],
    [$.expression, $.logical_and_expression],
    [$.expression, $.logical_or_expression],
    [$.expression, $.coalescing_expression],
    [$.expression, $.flow_expression],
    [$.expression, $.assignment_expression],
    [$.constant_identifier, $.type_identifier, $.identifier_expression],
    [$.constant_pattern, $.primary_expression],
    [$.range_expression],
    [$.range_expression, $.type_cast_expression],
    [$.range_expression, $.type_test_expression],
    [$.range_expression, $.control_transfer_expression],
    [$.range_expression, $.address_of_expression],
    [$.lambda_expression, $.macro_block_argument],
    [$.struct_constant_expression, $.type],
    [$.super_class_or_interfaces],
    [$.type_identifier, $.generic_type],
    [$.constant_identifier, $.type_identifier, $.binding_pattern, $.enum_pattern, $.identifier_expression],
    [$.constant_identifier, $.identifier_expression],
    [$.binding_pattern, $.annotation_argument],
    [$.type_identifier, $.enum_pattern, $.identifier_expression],
    [$.constant_identifier, $.generic_type, $.identifier_expression],
    [$.primitive_type, $.numeric_type],
    [$.constant_pattern, $.expression],
    [$.literal, $.constant_expression],
    [$.struct_constant_expression, $.type, $.struct_pattern],
    [$.constant_identifier, $.type_identifier, $.binding_pattern, $.enum_pattern, $.left_value_expression],
    [$.constant_identifier, $.type_identifier, $.binding_pattern, $.enum_pattern, $.identifier_expression, $.left_value_expression],
    [$.constant_identifier, $.binding_pattern, $.enum_pattern, $.identifier_expression],
    [$.constant_identifier, $.type_identifier, $.left_value_expression],
    [$.constant_identifier, $.type_identifier, $.identifier_expression, $.left_value_expression],
    [$.type_identifier, $.binding_pattern, $.enum_pattern, $.identifier_expression],
    [$.enum_pattern, $.identifier_expression],
    [$.binding_pattern, $.enum_pattern, $.identifier_expression],
    [$.type, $.struct_pattern],
    [$.type_identifier, $.binding_pattern, $.enum_pattern, $.left_value_expression],
    [$.type_identifier, $.binding_pattern, $.enum_pattern, $.identifier_expression, $.left_value_expression],
    [$.multi_line_raw_string_literal],
    [$.foreign_function_declaration, $.function_modifier],
    [$.foreign_type_declaration, $.class_modifier],
    [$.foreign_type_declaration, $.struct_modifier],
    [$.binding_pattern, $.enum_pattern],
    [$.constant_declaration, $.binding_pattern, $.enum_pattern],
    [$.literal, $.constant_literal],
    [$.pattern, $.type_pattern],
    [$.type_identifier, $.identifier_expression],
    [$.constant_identifier, $.generic_type],
    [$.identifier_expression, $.left_value_expression],
    [$.type_identifier, $.binding_pattern, $.enum_pattern],
    [$.lambda_expression, $.block],
    [$.block, $.interpolated_quote],
    [$.expression, $.interpolated_quote],
    [$.member_access_expression],
    [$.generic_type, $.identifier_expression],
    [$.integer_literal, $.float_literal],
    [$.nothing_literal, $.primitive_type],
    [$.control_transfer_expression],
    [$.expression, $._expression],
    [$.expression, $._expression, $.spawn_expression],
    [$.spawn_expression, $._expression],
    [$.annotation, $.macro_invocation],
    [$.class_body],
    [$.struct_body],
    [$.line_string_interpolation, $.member_access_expression],
    [$.line_string_interpolation, $.call_expression],
    [$.line_string_interpolation, $.index_access_expression],
    [$.line_string_interpolation, $.member_access_expression, $.call_expression, $.index_access_expression],
    [$.left_value_expression, $._expression],
    [$.variable_declaration, $.annotation],
    [$.type_parameter],
    [$.function_modifier, $.static_function_declaration],
    [$.unary_constant_expression, $.binary_constant_expression],
    [$.unary_constant_expression, $.range_constant_expression],
    [$.range_constant_expression, $.binary_constant_expression],
    [$.range_constant_expression],
    [$.constant_identifier, $.type_identifier],
    [$.parenthesized_constant_expression, $.tuple_constant_expression],
    [$.binary_constant_expression],
    [$.identifier_expression, $.lambda_parameter],
    [$.type_identifier, $.identifier_expression, $.lambda_parameter],
    [$.member_access_expression, $.expression_or_declaration],
    [$.call_expression, $.expression_or_declaration],
    [$.index_access_expression, $.expression_or_declaration],
    [$.member_access_expression, $.call_expression, $.index_access_expression, $.expression_or_declaration],
    [$.variable_declaration, $.annotation_expression],
    [$.struct_construction_expression, $.pointer_type],
    [$.member_access_expression, $.pointer_access_expression],
    [$.type_cast_expression, $.pointer_access_expression],
    [$.call_expression, $.pointer_access_expression],
    [$.range_expression, $.pointer_access_expression],
    [$.index_access_expression, $.pointer_access_expression],
    [$.member_access_expression, $.call_expression, $.index_access_expression, $.pointer_access_expression],
    [$.type_test_expression, $.pointer_access_expression],
    [$.coalescing_expression, $.pointer_access_expression],
    [$.flow_expression, $.pointer_access_expression],
    [$.member_access_expression, $.unary_expression],
    [$.unary_expression, $.type_cast_expression],
    [$.call_expression, $.unary_expression],
    [$.unary_expression, $.range_expression],
    [$.index_access_expression, $.unary_expression],
    [$.member_access_expression, $.call_expression, $.index_access_expression, $.unary_expression],
    [$.unary_expression, $.type_test_expression],
    [$.unary_expression, $.coalescing_expression],
    [$.unary_expression, $.flow_expression],
    [$.expression, $._expression, $.left_value_expression],
    [$.type_identifier, $.left_value_expression],
    [$.type_identifier, $.identifier_expression, $.left_value_expression],
    [$.expression, $.left_value_expression],
    [$.member_access_expression, $.address_of_expression],
    [$.type_cast_expression, $.address_of_expression],
    [$.call_expression, $.address_of_expression],
    [$.range_expression, $.address_of_expression],
    [$.index_access_expression, $.address_of_expression],
    [$.member_access_expression, $.call_expression, $.index_access_expression, $.address_of_expression],
    [$.type_test_expression, $.address_of_expression],
    [$.coalescing_expression, $.address_of_expression],
    [$.flow_expression, $.address_of_expression],
    [$.member_access_expression, $.control_transfer_expression],
    [$.control_transfer_expression, $.type_cast_expression],
    [$.call_expression, $.control_transfer_expression],
    [$.range_expression, $.control_transfer_expression],
    [$.index_access_expression, $.control_transfer_expression],
    [$.control_transfer_expression, $.type_test_expression],
    [$.control_transfer_expression, $.coalescing_expression],
    [$.control_transfer_expression, $.flow_expression],
    [$.expression, $.spawn_expression],
    [$.member_access_expression, $.call_expression, $.index_access_expression, $.control_transfer_expression],
    [$.constant_identifier, $.binding_pattern, $.enum_pattern],
    [$.type_identifier, $.enum_pattern],
    [$.constant_if_expression, $.binary_constant_expression],
    [$.constant_if_expression, $.range_constant_expression],
    [$.constant_expression, $.constant_if_expression],
    [$.constant_identifier, $.type_identifier, $.binding_pattern, $.enum_pattern],
    [$.unary_expression, $._expression],
    [$.primary_expression, $.spawn_expression],
    [$.type_identifier, $.lambda_parameter],
    [$.assignment_expression, $.type_cast_expression],
    [$.assignment_expression, $.range_expression],
    [$.assignment_expression, $.type_test_expression],
    ],
  word: $ => $.identifier,

  rules: {
    source_file: $ => repeat($.top_level_declaration),

    // 顶级声明（包含包/导入/导出）
    top_level_declaration: $ => choice(
      $.package_declaration,
      $.import_declaration,
      $.export_declaration,
      $.declaration
    ),

    // 11. 包与模块（Packages & Modules）
    package_declaration: $ => seq(
      'package',
      $.package_identifier,
      optional(seq('from', $.string_literal)) // 可选包路径
    ),
    package_identifier: $ => seq($.identifier, repeat(seq('.', $.identifier))),

    import_declaration: $ => choice(
      // 基础导入
      seq(
        'import',
        $.package_identifier,
        optional(seq('as', $.identifier))
      ),
      // 选择性导入（带重命名）
      seq(
        'import',
        '{',
        seq($.import_specifier, repeat(seq(',', $.import_specifier))),
        '}',
        'from',
        $.package_identifier
      ),
      // 通配符导入
      seq(
        'import',
        '*',
        'as',
        $.identifier,
        'from',
        $.package_identifier
      ),
      // 相对导入
      seq(
        'import',
        choice('./', '../'),
        $.package_identifier,
        optional(seq('as', $.identifier))
      )
    ),
    import_specifier: $ => choice(
      $.identifier,
      seq($.identifier, 'as', $.identifier),
      seq('{', seq($.import_specifier, repeat(seq(',', $.import_specifier))), '}') // 嵌套导入
    ),
    // 导出声明
    export_declaration: $ => seq(
      'export',
      choice(
        $.variable_declaration,
        $.function_declaration,
        $.class_declaration,
        $.interface_declaration,
        $.struct_declaration,
        $.enum_declaration,
        $.type_alias_declaration,
        seq('{', seq($.identifier, repeat(seq(',', $.identifier))), '}') // 批量导出
      )
    ),

    // 1. 词法结构（Lexical Structure）
    declaration: $ => choice(
      $.variable_declaration,
      $.function_declaration,
      $.class_declaration,
      $.interface_declaration,
      $.struct_declaration,
      $.enum_declaration,
      $.type_alias_declaration,
      $.extend_declaration,
      $.macro_declaration,
      $.annotation_declaration,
      $.constant_declaration,
      $.foreign_function_declaration,
      $.foreign_type_declaration,
      $.native_type_alias
    ),

    // 1.1 标识符与关键字
    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
    raw_identifier: $ => /`[a-zA-Z_][a-zA-Z0-9_]*`/,
    keyword: $ => choice(
      // 核心关键字
      'as', 'break', 'Bool', 'case', 'catch', 'class', 'const', 'continue', 'Rune',
      'do', 'else', 'enum', 'extend', 'for', 'from', 'func', 'false', 'finally',
      'foreign', 'Float16', 'Float32', 'Float64', 'if', 'in', 'is', 'init', 'inout',
      'import', 'interface', 'Int8', 'Int16', 'Int32', 'Int64', 'IntNative', 'let', 'mut',
      'main', 'macro', 'match', 'Nothing', 'operator', 'prop', 'package', 'quote', 'return',
      'spawn', 'super', 'static', 'struct', 'synchronized', 'try', 'this', 'true', 'type',
      'throw', 'This', 'unsafe', 'Unit', 'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
      'var', 'VArray', 'where', 'while',
      // 上下文关键字
      'abstract', 'open', 'override', 'private', 'protected', 'public', 'redef', 'get', 'set', 'sealed'
    ),

    // 1.2 注释
    comment: $ => choice(
      $.line_comment,
      $.block_comment
    ),
    line_comment: $ => /\/\/.*/,
    block_comment: $ => /\/\*[\s\S]*?\*\//,

    // 1.3 字面量
    literal: $ => choice(
      $.integer_literal,
      $.float_literal,
      $.rune_literal,
      $.boolean_literal,
      $.string_literal,
      $.unit_literal,
      $.nothing_literal,
      $.constant_literal,
    ),

    // 整数字面量（支持二进制、八进制、十进制、十六进制 + 后缀）
    integer_literal: $ => seq(
      choice(
        // 二进制：0b/0B 前缀
        seq(choice('0b', '0B'), repeat1($.bin_digit), optional($.integer_suffix)),
        // 八进制：0o/0O 前缀
        seq(choice('0o', '0O'), repeat1($.octal_digit), optional($.integer_suffix)),
        // 十进制：无前缀，支持下划线分隔
        seq($.decimal_literal, optional($.integer_suffix)),
        // 十六进制：0x/0X 前缀
        seq(choice('0x', '0X'), repeat1($.hex_digit), optional($.integer_suffix))
      )
    ),
    bin_digit: $ => /[01]/,
    octal_digit: $ => /[0-7]/,
    decimal_literal: $ => /[1-9][0-9_]*|[0]/,
    hex_digit: $ => /[0-9a-fA-F]/,
    integer_suffix: $ => choice('i8', 'i16', 'i32', 'i64', 'u8', 'u16', 'u32', 'u64'),

    // 浮点数字面量（十进制、十六进制 + 后缀）
    float_literal: $ => seq(
      choice(
        // 十进制浮点数
        seq(
          choice(
            seq($.decimal_literal, $.decimal_fraction, optional($.decimal_exponent)),
            seq($.decimal_literal, $.decimal_exponent),
            seq($.decimal_fraction, $.decimal_exponent)
          ),
          optional($.float_suffix)
        ),
        // 十六进制浮点数（必须含指数部分）
        seq(
          choice('0x', '0X'),
          choice(
            seq(repeat1($.hex_digit), $.hex_fraction),
            repeat1($.hex_digit)
          ),
          $.hex_exponent,
          optional($.float_suffix)
        )
      )
    ),
    decimal_fraction: $ => seq('.', $.decimal_fragment),
    decimal_fragment: $ => /[0-9_]+/,
    decimal_exponent: $ => seq(choice('e', 'E'), optional(choice('+', '-')), $.decimal_fragment),
    hex_fraction: $ => seq('.', repeat1($.hex_digit)),
    hex_exponent: $ => seq(choice('p', 'P'), optional(choice('+', '-')), $.decimal_fragment),
    float_suffix: $ => choice('f16', 'f32', 'f64'),

    // Rune 字面量（r + 单/双引号字符串）
    rune_literal: $ => seq(
      'r',
      choice(
        seq("'", choice($.single_char, $.escape_sequence), "'"),
        seq('"', choice($.single_char, $.escape_sequence), '"')
      )
    ),
    single_char: $ => /[^'\\\r\n]/,
    escape_sequence: $ => choice(
      $.unicode_escape,
      $.simple_escape
    ),
    unicode_escape: $ => seq(
      '\\u{',
      repeat1($.hex_digit),
      '}'
    ),
    simple_escape: $ => seq(
      '\\',
      choice('t', 'b', 'r', 'n', "'", '"', '\\', 'f', 'v', '0', '$')
    ),

    // 布尔字面量
    boolean_literal: $ => choice('true', 'false'),

    // 字符串字面量（单行、多行、多行原始）
    string_literal: $ => choice(
      $.line_string_literal,
      $.multi_line_string_literal,
      $.multi_line_raw_string_literal
    ),
    line_string_literal: $ => seq(
      choice('"', "'"),
      repeat(choice($.line_string_content, $.line_string_interpolation)),
      choice('"', "'")
    ),
    line_string_content: $ => /[^"\\\r\n$]+|\\./,
    line_string_interpolation: $ => seq(
      '${',
      repeat($.expression),
      '}'
    ),
    multi_line_string_literal: $ => seq(
      choice('"""', "'''"),
      /\r?\n/,
      repeat(choice($.multi_line_string_content, $.multi_line_string_interpolation)),
      choice('"""', "'''")
    ),
    multi_line_string_content: $ => /[^"\\$]+|\\./,
    multi_line_string_interpolation: $ => seq(
      '${',
      repeat($.expression),
      '}'
    ),
    multi_line_raw_string_literal: $ => seq(
      repeat1('#'),
      choice('"', "'"),
      repeat(/[^"#]+/),
      choice('"', "'"),
      repeat1('#')
    ),

    // Unit 字面量（()）
    unit_literal: $ => '()',
    // Nothing 字面量（无显式字面量，通过上下文推断）
    nothing_literal: $ => 'Nothing',

    // 16. 常量求值（Constant Evaluation）
    constant_declaration: $ => seq(
      optional($.annotation),
      'const',
      $.identifier,
      optional(seq(':', $.type)),
      '=',
      $.constant_expression
    ),
    constant_literal: $ => choice(
      $.integer_literal,
      $.float_literal,
      $.boolean_literal,
      $.rune_literal,
      $.string_literal,
      $.unit_literal
    ),
    constant_identifier: $ => $.identifier, // 引用其他常量
    // 常量表达式（完整语法）
    constant_expression: $ => choice(
      $.constant_literal,
      $.constant_identifier,
      $.unary_constant_expression,
      $.binary_constant_expression,
      $.parenthesized_constant_expression,
      $.tuple_constant_expression,
      $.array_constant_expression,
      $.struct_constant_expression,
      $.enum_constant_expression,
      $.range_constant_expression,
      $.constant_type_cast,
      $.constant_if_expression
    ),
    constant_type_cast: $ => seq($.type, '(', $.constant_expression, ')'),
    // 常量条件表达式（编译期分支消除）
    constant_if_expression: $ => seq(
      'if',
      '(',
      $.constant_expression,
      ')',
      '{',
      $.constant_expression,
      '}',
      optional(seq(
        'else',
        choice(
          '{', $.constant_expression, '}',
          $.constant_if_expression
        )
      ))
    ),
    // 范围常量表达式
    range_constant_expression: $ => seq(
      $.constant_expression,
      choice('..', '..='),
      $.constant_expression,
      optional(seq(':', $.constant_expression))
    ),
    unary_constant_expression: $ => seq(
      choice('+', '-', '!'),
      $.constant_expression
    ),
    binary_constant_expression: $ => seq(
      $.constant_expression,
      choice('+', '-', '*', '/', '%', '**', '&', '|', '^', '<<', '>>', '&&', '||', '==', '!=', '<', '<=', '>', '>='),
      $.constant_expression
    ),
    parenthesized_constant_expression: $ => seq(
      '(',
      $.constant_expression,
      ')'
    ),
    tuple_constant_expression: $ => seq(
      '(',
      sep1($.constant_expression, ','),
      ')'
    ),
    array_constant_expression: $ => seq(
      '[',
      sep1($.constant_expression, ','),
      ']'
    ),
    struct_constant_expression: $ => seq(
      $.type_identifier,
      '{',
      sep1($.struct_field_constant, ','),
      '}'
    ),
    struct_field_constant: $ => seq(
      $.identifier,
      ':',
      $.constant_expression
    ),
    enum_constant_expression: $ => seq(
      $.type_identifier,
      '.',
      $.identifier,
      optional(seq('(', sep1($.constant_expression, ','), ')'))
    ),

    // 2. 类型系统（Types）
    type: $ => choice(
      // 基础类型
      $.primitive_type,
      // 复合类型
      $.tuple_type,
      $.array_type,
      $.varray_type,
      $.range_type,
      $.function_type,
      $.option_type,
      $.pointer_type,
      // 类型引用
      $.type_identifier,
      $.generic_type,
    ),

    primitive_type: $ => choice(
      // 数值类型
      'Int8', 'Int16', 'Int32', 'Int64', 'IntNative',
      'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
      'Float16', 'Float32', 'Float64',
      // 其他基础类型
      'Bool', 'Rune', 'String', 'Unit', 'Nothing'
    ),

    // 元组类型（(Type1, Type2, ...)）
    tuple_type: $ => seq(
      '(',
      seq($.type, repeat(seq(',', $.type))),
      ')'
    ),

    // 数组类型（Array<T>）
    array_type: $ => seq(
      'Array',
      '<',
      $.type,
      '>'
    ),

    // VArray 类型（VArray<T, $N>，N 为整数字面量）
    varray_type: $ => seq(
      'VArray',
      '<',
      $.type,
      ',',
      '$',
      $.integer_literal,
      '>'
    ),

    // Range 类型（Range<T>）
    range_type: $ => seq(
      'Range',
      '<',
      $.type,
      '>'
    ),

    // 函数类型（(T1, T2) -> R）
    function_type: $ => seq(
      '(',
      optional(sep1($.type, ',')),
      ')',
      '->',
      $.type
    ),

    // Option 类型（?T 或 Option<T>）
    option_type: $ => choice(
      seq('?', $.type),
      seq('Option', '<', $.type, '>')
    ),

    // 类型标识符（引用已定义类型）
    type_identifier: $ => $.identifier,

    // 泛型类型（Type<T1, T2>）
    generic_type: $ => seq(
      $.identifier,
      '<',
      sep1($.type, ','),
      '>'
    ),

    // 类型参数引用（T）
    type_parameter_reference: $ => $.identifier,

    // 3. 变量与作用域（Variables & Scope）
    variable_declaration: $ => seq(
      optional($.annotation),
      optional($.variable_modifier),
      choice('let', 'var', 'const'),
      sep1($.pattern, ','),
      optional(seq(':', $.type)),
      optional(seq('=', $.expression))
    ),
    variable_modifier: $ => choice(
      'public', 'private', 'protected', 'internal', 'static'
    ),
    pattern: $ => choice(
      $.wildcard_pattern,
      $.binding_pattern,
      $.tuple_pattern,
      $.enum_pattern,
      $.type_pattern,
      $.constant_pattern,
      $.struct_pattern,
      $.array_pattern
    ),
    wildcard_pattern: $ => '_',
    binding_pattern: $ => $.identifier,
    tuple_pattern: $ => seq(
      '(',
      sep1($.pattern, ','),
      ')'
    ),
    enum_pattern: $ => seq(
      $.identifier,
      optional(seq('(', sep1($.pattern, ','), ')'))
    ),
    type_pattern: $ => seq(
      choice($.wildcard_pattern, $.binding_pattern),
      ':',
      $.type
    ),
    constant_pattern: $ => $.literal,
    struct_pattern: $ => seq(
      $.type_identifier,
      '{',
      sep1($.struct_field_pattern, ','),
      '}'
    ),
    struct_field_pattern: $ => seq(
      $.identifier,
      ':',
      $.pattern
    ),
    array_pattern: $ => seq(
      '[',
      sep1($.pattern, ','),
      optional(seq('..', $.pattern)),
      ']'
    ),

    // 4. 表达式（Expressions）
    // 主表达式入口 - 所有表达式最终解析为这个规则
    expression: $ => choice(
      // 优先级表达式链（从最低到最高）
      $.assignment_expression,
      $.range_expression,
      $.type_test_expression,
      $.type_cast_expression,
      $.numeric_conversion_expression,
      $.control_transfer_expression,
      $.if_expression,
      $.if_let_expression,
      $.match_expression,
      $.for_in_expression,
      $.while_expression,
      $.do_while_expression,
      $.try_expression,
      $.spawn_expression,
      $.synchronized_expression,
      $.quote_expression,
      $.unquote_expression,
      $.unquote_splice_expression,
      $.macro_invocation,
      $.struct_construction_expression,
      $.array_construction_expression,
      $.annotation_expression,
      $.pointer_access_expression,
      $.address_of_expression,
      $.flow_expression,
      $.coalescing_expression,
      $.logical_or_expression,
      $.logical_and_expression,
      $.bitwise_or_expression,
      $.bitwise_xor_expression,
      $.bitwise_and_expression,
      $.equality_expression,
      $.relational_expression,
      $.bitwise_shift_expression,
      $.additive_expression,
      $.multiplicative_expression,
      $.exponentiation_expression,
      $.unary_expression,
      $.primary_expression
    ),

    // 标识符表达式（变量/函数引用）
    identifier_expression: $ => $.identifier,
    
    // 括号表达式（(expr)）
    parenthesized_expression: $ => seq(
      '(',
      $.expression,
      ')'
    ),
    
    // 成员访问表达式（obj.member）
    member_access_expression: $ => seq(
      $.primary_expression,
      optional('?'),
      '.',
      $.identifier,
      optional($.type_arguments)
    ),
    type_arguments: $ => seq(
      '<',
      sep1($.type, ','),
      '>'
    ),
    
    // 函数调用表达式（func(arg1, arg2)）
    call_expression: $ => seq(
      $.primary_expression,
      optional('?'),
      '(',
      optional(sep1($.argument, ',')),
      ')'
    ),
    argument: $ => choice(
      $.expression,
      $.named_argument,
      $.inout_argument
    ),
    named_argument: $ => seq(
      $.identifier,
      ':',
      $.expression
    ),
    inout_argument: $ => seq(
      'inout',
      $.expression
    ),
    
    // 索引访问表达式（obj[index]）
    index_access_expression: $ => seq(
      $.primary_expression,
      optional('?'),
      '[',
      $.expression,
      ']'
    ),

    // Lambda 表达式（{ (params) => body }）
    lambda_expression: $ => seq(
      '{',
      optional($.lambda_parameters),
      optional('=>'),
      repeat($.expression_or_declaration),
      '}'
    ),
    lambda_parameters: $ => sep1($.lambda_parameter, ','),
    lambda_parameter: $ => seq(
      choice($.identifier, '_'),
      optional(seq(':', $.type))
    ),
    expression_or_declaration: $ => choice(
      $.expression,
      $.variable_declaration
    ),

    // 表达式优先级层级（从高到低）
    // 1. 基础表达式（最高优先级）
    primary_expression: $ => choice(
      $.literal,
      $.identifier_expression,
      $.parenthesized_expression,
      $.member_access_expression,
      $.call_expression,
      $.index_access_expression,
      $.lambda_expression
    ),
    
    // 2. 一元表达式
    unary_expression: $ => choice(
      seq(choice('!', '-', '++', '--'), $.primary_expression),
      $.primary_expression
    ),
    
    // 3. 幂运算表达式（right associative）
    exponentiation_expression: $ => choice(
      prec.right(14, seq(
        $.unary_expression,
        '**',
        $.exponentiation_expression
      )),
      $.unary_expression
    ),
    
    // 4. 乘法表达式（left associative）
    multiplicative_expression: $ => choice(
      prec.left(13, seq(
        $.exponentiation_expression,
        choice('*', '/', '%'),
        $.multiplicative_expression
      )),
      $.exponentiation_expression
    ),
    
    // 5. 加法表达式（left associative）
    additive_expression: $ => choice(
      prec.left(12, seq(
        $.multiplicative_expression,
        choice('+', '-'),
        $.additive_expression
      )),
      $.multiplicative_expression
    ),
    
    // 6. 位移表达式（left associative）
    bitwise_shift_expression: $ => choice(
      prec.left(11, seq(
        $.additive_expression,
        choice('<<', '>>'),
        $.bitwise_shift_expression
      )),
      $.additive_expression
    ),
    
    // 7. 关系表达式（non-associative）
    relational_expression: $ => choice(
      prec(10, seq(
        $.bitwise_shift_expression,
        choice('<', '<=', '>', '>='),
        $.bitwise_shift_expression
      )),
      prec(10, seq(
        $.bitwise_shift_expression,
        choice('is', 'as'),
        $.bitwise_shift_expression
      )),
      $.bitwise_shift_expression
    ),
    
    // 8. 相等性表达式（non-associative）
    equality_expression: $ => choice(
      prec(9, seq(
        $.relational_expression,
        choice('==', '!='),
        $.relational_expression
      )),
      $.relational_expression
    ),
    
    // 9. 位与表达式（left associative）
    bitwise_and_expression: $ => choice(
      prec.left(8, seq(
        $.equality_expression,
        '&',
        $.bitwise_and_expression
      )),
      $.equality_expression
    ),
    
    // 10. 位异或表达式（left associative）
    bitwise_xor_expression: $ => choice(
      prec.left(7, seq(
        $.bitwise_and_expression,
        '^',
        $.bitwise_xor_expression
      )),
      $.bitwise_and_expression
    ),
    
    // 11. 位或表达式（left associative）
    bitwise_or_expression: $ => choice(
      prec.left(6, seq(
        $.bitwise_xor_expression,
        '|',
        $.bitwise_or_expression
      )),
      $.bitwise_xor_expression
    ),
    
    // 12. 逻辑与表达式（left associative）
    logical_and_expression: $ => choice(
      prec.left(5, seq(
        $.bitwise_or_expression,
        '&&',
        $.logical_and_expression
      )),
      $.bitwise_or_expression
    ),
    
    // 13. 逻辑或表达式（left associative）
    logical_or_expression: $ => choice(
      prec.left(4, seq(
        $.logical_and_expression,
        '||',
        $.logical_or_expression
      )),
      $.logical_and_expression
    ),
    
    // 14. 空合并表达式（left associative）
    coalescing_expression: $ => choice(
      prec.left(3, seq(
        $.logical_or_expression,
        '??',
        $.coalescing_expression
      )),
      $.logical_or_expression
    ),
    
    // 15. 流表达式（left associative）
    flow_expression: $ => choice(
      prec.left(2, seq(
        $.coalescing_expression,
        choice('|>', '~>'),
        $.flow_expression
      )),
      $.coalescing_expression
    ),
    
    // 16. 赋值表达式（最低优先级，右结合）
    assignment_expression: $ => choice(
      prec.right(1, seq(
        $.flow_expression,
        choice('=', '**=', '*=', '/=', '%=', '+=', '-=', '<<=', '>>=', '&=', '^=', '|=', '&&=', '||='),
        $.assignment_expression
      )),
      $.flow_expression
    ),
    
    // 表达式别名用于 backward compatibility
    _expression: $ => $.primary_expression,

    // 范围表达式（start..end:step 或 start..=end:step）
    range_expression: $ => seq(
      $.expression,
      choice('..', '..='),
      $.expression,
      optional(seq(':', $.expression))
    ),

    left_value_expression: $ => choice(
      $.identifier,
      $.member_access_expression,
      $.index_access_expression,
      $.tuple_left_value_expression
    ),
    tuple_left_value_expression: $ => seq(
      '(',
      sep1($.left_value_expression, ','),
      ')'
    ),

    // If 表达式（if (cond) { ... } else { ... }）
    if_expression: $ => seq(
      'if',
      '(',
      $.expression,
      ')',
      $.block,
      optional(seq('else', choice($.if_expression, $.block)))
    ),

    // If-let 表达式（if (let pat <- e) { ... }）
    if_let_expression: $ => seq(
      'if',
      '(',
      'let',
      $.pattern,
      '<-',
      $.expression,
      ')',
      $.block,
      optional(seq('else', choice($.if_expression, $.block)))
    ),

    // Match 表达式（match (e) { case ... => ... }）
    match_expression: $ => choice(
      // 带 selector 的 match
      seq(
        'match',
        '(',
        $.expression,
        ')',
        '{',
        repeat($.match_case),
        '}'
      ),
      // 不带 selector 的 match
      seq(
        'match',
        '{',
        repeat($.match_case_no_selector),
        '}'
      )
    ),
    match_case: $ => seq(
      'case',
      sep1($.pattern, '|'),
      optional($.pattern_guard),
      '=>',
      repeat($.expression_or_declaration)
    ),
    match_case_no_selector: $ => seq(
      'case',
      choice($.expression, '_'),
      '=>',
      repeat($.expression_or_declaration)
    ),
    pattern_guard: $ => seq(
      'where',
      $.expression
    ),
    block: $ => seq(
      '{',
      repeat($.expression_or_declaration),
      '}'
    ),

    // For-in 表达式（for (pat in e where cond) { ... }）
    for_in_expression: $ => seq(
      'for',
      '(',
      $.pattern,
      'in',
      $.expression,
      optional($.pattern_guard),
      ')',
      $.block
    ),

    // While 表达式（while (cond) { ... }）
    while_expression: $ => choice(
      // 普通 while
      seq(
        'while',
        '(',
        $.expression,
        ')',
        $.block
      ),
      // While-let 表达式
      seq(
        'while',
        '(',
        'let',
        $.pattern,
        '<-',
        $.expression,
        ')',
        $.block
      )
    ),

    // Do-while 表达式（do { ... } while (cond)）
    do_while_expression: $ => seq(
      'do',
      $.block,
      'while',
      '(',
      $.expression,
      ')'
    ),

    // Try 表达式（try { ... } catch { ... } finally { ... }）
    try_expression: $ => choice(
      // 普通 try
      seq(
        'try',
        $.block,
        repeat($.catch_clause),
        optional(seq('finally', $.block))
      ),
      // Try-with-resources
      seq(
        'try',
        '(',
        sep1($.resource_specification, ','),
        ')',
        $.block,
        repeat($.catch_clause),
        optional(seq('finally', $.block))
      )
    ),
    // 异常类型匹配
    catch_clause: $ => seq(
      'catch',
      '(',
      choice(
        $.wildcard_pattern,
        $.binding_pattern,
        $.exception_type_pattern
      ),
      ')',
      $.block
    ),
    exception_type_pattern: $ => seq(
      choice($.wildcard_pattern, $.binding_pattern),
      ':',
      $.type
    ),
    resource_specification: $ => seq(
      choice('let', 'var'),
      $.pattern,
      '=',
      $.expression
    ),

    // 控制转移表达式（break, continue, return, throw）
    control_transfer_expression: $ => choice(
      'break',
      'continue',
      seq('return', optional($.expression)),
      seq('throw', $.expression)
    ),

    // 类型测试表达式（e is T）
    type_test_expression: $ => seq(
      $.expression,
      'is',
      $.type
    ),

    // 类型转换表达式（e as T）
    type_cast_expression: $ => seq(
      $.expression,
      'as',
      $.type
    ),

    // 数值类型转换表达式（Type(e)）
    numeric_conversion_expression: $ => seq(
      $.numeric_type,
      '(',
      $.expression,
      ')'
    ),
    numeric_type: $ => choice(
      'Int8', 'Int16', 'Int32', 'Int64', 'IntNative',
      'UInt8', 'UInt16', 'UInt32', 'UInt64', 'UIntNative',
      'Float16', 'Float32', 'Float64'
    ),

    // 结构体构造表达式（Type { field: value, ... }）
    struct_construction_expression: $ => seq(
      $.type,
      '{',
      sep1($.struct_field_initializer, ','),
      '}'
    ),
    struct_field_initializer: $ => seq(
      $.identifier,
      ':',
      $.expression
    ),

    // 数组构造表达式（[e1, e2, ...] 或 Array<T>[e1, e2, ...]）
    array_construction_expression: $ => choice(
      seq(
        '[',
        sep1($.expression, ','),
        ']'
      ),
      seq(
        $.array_type,
        '[',
        sep1($.expression, ','),
        ']'
      )
    ),

    // 并发相关表达式
    // Spawn 表达式（spawn { ... } 或 spawn func()）
    spawn_expression: $ => seq(
      'spawn',
      choice(
        $.block,
        $.call_expression,
        $.lambda_expression
      )
    ),
    // Synchronized 表达式（synchronized (lock) { ... }）
    synchronized_expression: $ => seq(
      'synchronized',
      '(',
      $.expression,
      ')',
      $.block
    ),

    // 14. 元编程（Metaprogramming）
    // Quote 表达式（支持不同引用模式）
    quote_expression: $ => choice(
      // 表达式引用
      seq('quote', '(', $.expression, ')'),
      // 块引用
      seq('quote', $.block),
      // 类型引用
      seq('quote', '<', $.type, '>'),
      // 插值引用
      $.interpolated_quote
    ),
    interpolated_quote: $ => seq(
      'quote',
      '{',
      repeat(choice($.quote_fragment, $.unquote_expression, $.unquote_splice_expression)),
      '}'
    ),
    quote_fragment: $ => /[^{}]+/,
    // 普通解引用
    unquote_expression: $ => seq('${', $.expression, '}'),
    // 拼接解引用（用于数组/元组）
    unquote_splice_expression: $ => seq('$${', $.expression, '}'),

    // 17. 注解（Annotation）细节
    // 注解声明（带参数）
    annotation_declaration: $ => seq(
      optional($.annotation_modifier),
      'annotation',
      $.identifier,
      optional($.type_parameters),
      $.annotation_parameters,
      optional($.generic_constraints),
      optional($.annotation_body)
    ),
    annotation_modifier: $ => choice('public', 'private', 'internal'),
    annotation_parameters: $ => seq(
      '(',
      optional(sep1($.annotation_parameter, ',')),
      ')'
    ),
    annotation_parameter: $ => seq(
      $.identifier,
      ':',
      $.type,
      optional(seq('=', $.constant_expression)) // 默认值
    ),
    annotation_body: $ => seq('{', repeat($.annotation_member), '}'),
    annotation_member: $ => choice(
      $.variable_declaration,
      $.function_declaration
    ),
    // 注解应用（支持位置参数/命名参数）
    annotation: $ => seq(
      '@',
      $.identifier,
      optional($.type_arguments),
      optional(seq(
        '(',
        optional(sep1($.annotation_argument, ',')),
        ')'
      ))
    ),
    annotation_argument: $ => choice(
      $.constant_expression, // 位置参数
      seq($.identifier, ':', $.constant_expression) // 命名参数
    ),
    // 重复注解
    repeated_annotation: $ => seq(
      '@',
      '[',
      sep1($.annotation, ','),
      ']'
    ),
    annotation_expression: $ => $.annotation,

    // 13. 互操作（Interop）细节
    // 外部函数声明（带ABI指定）
    foreign_function_declaration: $ => seq(
      'foreign',
      optional(seq('abi', '(', $.string_literal, ')')), // ABI指定（如C/SystemV）
      'func',
      $.identifier,
      optional($.type_parameters),
      $.function_parameters,
      optional(seq(':', $.type)),
      ';' // 无函数体
    ),
    // 外部类型声明
    foreign_type_declaration: $ => seq(
      'foreign',
      choice('class', 'struct', 'enum'),
      $.identifier,
      optional($.type_parameters),
      ';' 
    ),
    // 不安全代码块
    unsafe_block: $ => seq(
      'unsafe',
      $.block
    ),
    // 指针操作（互操作专用）
    pointer_type: $ => seq('*', $.type),
    pointer_access_expression: $ => seq('*', $.expression),
    address_of_expression: $ => seq('&', $.expression),
    // 原生类型别名
    native_type_alias: $ => seq(
      'type',
      $.identifier,
      '=',
      seq('@', $.identifier) // 绑定原生类型
    ),

    // 5. 函数（Functions）
    function_declaration: $ => seq(
      optional($.annotation),
      optional($.function_modifier),
      'func',
      $.identifier,
      optional($.type_parameters),
      $.function_parameters,
      optional(seq(':', $.type)),
      optional($.generic_constraints),
      $.block
    ),
    function_modifier: $ => choice(
      'public', 'private', 'protected', 'internal',
      'static', 'open', 'override', 'redef', 'mut', 'foreign', 'unsafe'
    ),
    type_parameters: $ => seq(
      '<',
      sep1($.type_parameter, ','),
      '>'
    ),
    type_parameter: $ => seq(
      $.identifier,
      optional($.type_parameter_constraint)
    ),
    // 泛型多约束
    type_parameter_constraint: $ => seq(
      '<:',
      sep1($.type, '&')
    ),
    function_parameters: $ => seq(
      '(',
      optional(sep1($.function_parameter, ',')),
      ')'
    ),
    function_parameter: $ => choice(
      // 非命名参数
      seq(
        choice($.identifier, '_'),
        ':',
        $.type
      ),
      // 命名参数（! 标记）
      seq(
        $.identifier,
        '!',
        ':',
        $.type,
        optional(seq('=', $.expression))
      ),
      // Inout 参数
      seq(
        'inout',
        $.identifier,
        ':',
        $.type
      )
    ),
    // 泛型约束
    generic_constraints: $ => seq(
      'where',
      sep1($.generic_constraint, ',')
    ),
    generic_constraint: $ => choice(
      // 单约束 T <: A
      seq(
        $.type_parameter,
        '<:',
        $.type
      ),
      // 多约束 T <: A & B
      seq(
        $.type_parameter,
        '<:',
        sep1($.type, '&')
      ),
      // 类型关系约束 T == U
      seq(
        $.type_parameter,
        '==',
        $.type
      )
    ),

    // 6. 类与接口（Classes & Interfaces）
    // 6.1 类声明
    class_declaration: $ => seq(
      optional($.annotation),
      optional($.class_modifier),
      'class',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', $.super_class_or_interfaces)),
      optional($.generic_constraints),
      $.class_body
    ),
    class_modifier: $ => choice(
      'public', 'private', 'protected', 'internal',
      'open', 'sealed', 'abstract', 'foreign', 'unsafe'
    ),
    super_class_or_interfaces: $ => choice(
      seq($.type, optional(seq('&', sep1($.type, '&')))),
      sep1($.type, '&')
    ),
    class_body: $ => seq(
      '{',
      repeat(choice(
        $.class_init,
        $.static_init,
        $.variable_declaration,
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.class_finalizer,
        $.macro_invocation
      )),
      optional($.class_primary_init),
      repeat(choice(
        $.class_init,
        $.static_init,
        $.variable_declaration,
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.class_finalizer,
        $.macro_invocation
      )),
      '}'
    ),
    // 类主构造函数
    class_primary_init: $ => seq(
      optional($.class_member_modifier),
      $.identifier,
      '(',
      optional($.class_primary_init_params),
      ')',
      '{',
      optional($.super_call),
      repeat($.expression_or_declaration),
      '}'
    ),
    class_primary_init_params: $ => sep1($.class_primary_init_param, ','),
    class_primary_init_param: $ => choice(
      // 普通参数
      seq(
        optional($.class_member_modifier),
        choice('let', 'var'),
        $.identifier,
        ':',
        $.type
      ),
      // 命名参数（! 标记）
      seq(
        optional($.class_member_modifier),
        choice('let', 'var'),
        $.identifier,
        '!',
        ':',
        $.type,
        optional(seq('=', $.expression))
      )
    ),
    class_member_modifier: $ => choice('public', 'private', 'protected', 'internal'),
    super_call: $ => seq('super', '(', optional(sep1($.expression, ',')), ')'),
    // 类构造函数（init）
    class_init: $ => seq(
      optional($.class_member_modifier),
      'init',
      '(',
      optional($.function_parameters),
      ')',
      '{',
      optional(choice($.super_call, $.this_call)),
      repeat($.expression_or_declaration),
      '}'
    ),
    this_call: $ => seq('this', '(', optional(sep1($.expression, ',')), ')'),
    // 静态初始化器
    static_init: $ => seq(
      'static',
      'init',
      '(',
      ')',
      '{',
      repeat($.expression_or_declaration),
      '}'
    ),
    // 类终结器（~init()）
    class_finalizer: $ => seq(
      '~',
      'init',
      '(',
      ')',
      $.block
    ),

    // 6.2 接口声明
    interface_declaration: $ => seq(
      optional($.annotation),
      optional($.interface_modifier),
      'interface',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.interface_body
    ),
    interface_modifier: $ => choice('public', 'sealed', 'open'),
    interface_body: $ => seq(
      '{',
      repeat(choice(
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.static_function_declaration,
        $.macro_invocation
      )),
      '}'
    ),
    static_function_declaration: $ => seq(
      'static',
      $.function_declaration
    ),

    // 7. 结构体（Structs）
    struct_declaration: $ => seq(
      optional($.annotation),
      optional($.struct_modifier),
      'struct',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.struct_body
    ),
    struct_modifier: $ => choice('public', 'private', 'internal', 'foreign', 'unsafe'),
    struct_body: $ => seq(
      '{',
      repeat(choice(
        $.struct_init,
        $.static_init,
        $.variable_declaration,
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.macro_invocation
      )),
      optional($.struct_primary_init),
      repeat(choice(
        $.struct_init,
        $.static_init,
        $.variable_declaration,
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.macro_invocation
      )),
      '}'
    ),
    // 结构体主构造函数
    struct_primary_init: $ => seq(
      optional($.struct_member_modifier),
      $.identifier,
      '(',
      optional($.struct_primary_init_params),
      ')',
      '{',
      repeat($.expression_or_declaration),
      '}'
    ),
    struct_primary_init_params: $ => sep1($.struct_primary_init_param, ','),
    struct_primary_init_param: $ => choice(
      seq(
        optional($.struct_member_modifier),
        choice('let', 'var'),
        $.identifier,
        ':',
        $.type
      ),
      seq(
        optional($.struct_member_modifier),
        choice('let', 'var'),
        $.identifier,
        '!',
        ':',
        $.type,
        optional(seq('=', $.expression))
      )
    ),
    struct_member_modifier: $ => choice('public', 'private', 'internal'),
    // 结构体构造函数
    struct_init: $ => seq(
      optional($.struct_member_modifier),
      'init',
      '(',
      optional($.function_parameters),
      ')',
      '{',
      optional($.this_call),
      repeat($.expression_or_declaration),
      '}'
    ),

    // 8. 枚举（Enums）
    enum_declaration: $ => seq(
      optional($.annotation),
      optional($.enum_modifier),
      'enum',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.enum_body
    ),
    enum_modifier: $ => choice('public', 'private', 'internal'),
    enum_body: $ => seq(
      '{',
      optional('|'),
      sep1($.enum_case, '|'),
      repeat($.enum_member),
      '}'
    ),
    enum_case: $ => seq(
      optional($.annotation),
      $.identifier,
      optional(seq('(', sep1($.type, ','), ')'))
    ),
    enum_member: $ => choice(
      $.function_declaration,
      $.operator_declaration,
      $.property_declaration,
      $.macro_invocation
    ),

    // 9. 属性（Properties）
    property_declaration: $ => seq(
      optional($.annotation),
      optional($.property_modifier),
      'prop',
      $.identifier,
      ':',
      $.type,
      optional($.property_body)
    ),
    property_modifier: $ => choice(
      'public', 'private', 'protected', 'internal',
      'static', 'open', 'override', 'redef', 'mut'
    ),
    property_body: $ => seq(
      '{',
      repeat($.property_member),
      '}'
    ),
    property_member: $ => choice(
      seq('get', '(', ')', $.block),
      seq('set', '(', $.identifier, ')', $.block),
      $.annotation
    ),

    // 10. 扩展（Extend）
    extend_declaration: $ => seq(
      optional($.annotation),
      'extend',
      optional($.type_parameters),
      $.type,
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.extend_body
    ),
    extend_body: $ => seq(
      '{',
      repeat(choice(
        $.function_declaration,
        $.operator_declaration,
        $.property_declaration,
        $.macro_invocation
      )),
      '}'
    ),

    // 11. 类型别名（Type Aliases）
    type_alias_declaration: $ => seq(
      optional($.annotation),
      optional($.type_alias_modifier),
      'type',
      $.identifier,
      optional($.type_parameters),
      '=',
      $.type
    ),
    type_alias_modifier: $ => choice('public', 'private', 'internal'),

    // 12. 操作符重载（Operator Overloading）
    operator_declaration: $ => seq(
      optional($.annotation),
      optional($.function_modifier),
      'operator',
      $.operator,
      $.function_parameters,
      optional(seq(':', $.type)),
      optional($.generic_constraints),
      $.block
    ),
    operator: $ => choice(
      // 算术操作符
      '+', '-', '*', '/', '%', '**',
      // 位操作符
      '!', '&', '|', '^', '<<', '>>',
      // 逻辑操作符
      '&&', '||',
      // 关系操作符
      '==', '!=', '<', '<=', '>', '>=',
      // 赋值操作符
      '=', '**=', '*=', '/=', '%=', '+=', '-=', '<<=', '>>=', '&=', '^=', '|=', '&&=', '||=',
      // 其他操作符
      '??', '|>', '~>', '..', '..='
    ),

    // 13. 宏（Macros）
    macro_declaration: $ => seq(
      optional($.annotation),
      optional($.macro_modifier),
      'macro',
      $.identifier,
      optional($.type_parameters),
      $.function_parameters,
      optional(seq(':', $.type)),
      optional($.generic_constraints),
      $.block
    ),
    macro_modifier: $ => choice('public', 'private', 'internal'),
    // 宏调用（带参数展开）
    macro_invocation: $ => seq(
      '@',
      $.identifier,
      optional($.type_arguments),
      '(',
      optional(sep1($.macro_argument, ',')),
      ')'
    ),
    macro_argument: $ => choice(
      $.expression,
      $.pattern,
      $.type,
      $.macro_block_argument
    ),
    macro_block_argument: $ => seq('{', repeat($.expression_or_declaration), '}'),
  }
});
