// Define helper functions
const sep1 = (rule, sep) => seq(rule, repeat(seq(sep, rule)));

module.exports = grammar({
  name: 'cangjie',
  externals: $ => [
    $.multi_line_raw_string_literal,
    $.indent,
    $.dedent,
    $.newline
  ],
  extras: $ => [
    $.comment,
    /\s+/,
  ],
  conflicts: $ => [
    // Nothing 既可以作为字面量也可以作为类型，需要处理冲突
    [$.nothing_literal, $.primitive_type],
    // 类型标识符后面跟着 < 时，既可以作为泛型类型也可以作为标识符表达式，需要处理冲突
    [$.generic_type, $.identifier_expression],
    // let 后面跟着标识符和 @ 时，既可以作为绑定模式也可以作为枚举模式，需要处理冲突
    [$.binding_pattern, $.enum_pattern],
    // let 后面跟着通配符和 : 时，既可以作为模式也可以作为类型模式，需要处理冲突
    [$.pattern, $.type_pattern],
    // @ 后面跟着标识符和括号时，既可以作为注解也可以作为宏调用，需要处理冲突
    [$.annotation, $.macro_invocation],
    // @ 后面跟着标识符和括号内的标识符时，既可以作为绑定模式、枚举模式也可以作为标识符表达式，需要处理冲突
    [$.binding_pattern, $.enum_pattern, $.identifier_expression],
    // @ 后面跟着标识符和括号内的字面量时，既可以作为常量模式也可以作为主表达式，需要处理冲突
    [$.constant_pattern, $.primary_expression],
    // @ 后面跟着标识符和括号内的表达式时，既可以作为注解也可以作为宏参数，需要处理冲突
    [$.annotation, $.macro_argument],
    // @ 后面跟着标识符和括号内的标识符后面跟着 : 时，既可以作为绑定模式也可以作为命名参数，需要处理冲突
    [$.binding_pattern, $.named_argument],
    // @ 后面跟着标识符和括号内的 { ( identifier 时，既可以作为标识符表达式也可以作为lambda参数，需要处理冲突
    [$.identifier_expression, $.lambda_parameter],
    // let 后面跟着类型标识符和 { 时，既可以作为变量声明也可以作为结构体模式，需要处理冲突
    [$.variable_declaration, $.struct_pattern],
    // 注解中标识符既可以作为绑定模式也可以作为标识符表达式，需要处理冲突
    [$.binding_pattern, $.identifier_expression]
  ],
  rules: {
    // 根规则
    source_file: $ => repeat($.expression_or_declaration),
    
    // 表达式或声明（用于支持混合表达式和声明的上下文）
    expression_or_declaration: $ => choice(
      $.expression,
      $.declaration
    ),
    
    // 声明
    declaration: $ => choice(
      $.variable_declaration,
      $.function_declaration,
      $.class_declaration,
      $.struct_declaration,
      $.enum_declaration,
      $.extend_declaration,
      $.type_alias_declaration,
      $.operator_declaration,
      $.macro_declaration,
      $.import_declaration
    ),
    
    // 导入声明
    import_declaration: $ => seq(
      'import',
      $.package_identifier,
      optional(seq('.', '*')),
      optional(seq('as', $.identifier))
    ),
    package_identifier: $ => prec.left(1, seq(
      $.identifier,
      repeat(seq('.', $.identifier))
    )),
    
    // 注解
    annotation: $ => seq(
      '@',
      $.identifier,
      optional($.type_arguments),
      optional(seq('(', optional(sep1($.expression, ',')), ')'))
    ),
    
    // 标识符
    identifier: $ => /[a-z_][a-zA-Z0-9_]*/,
    raw_identifier: $ => /`[a-zA-Z_][a-zA-Z0-9_]*`/,
    
    // 注释
    comment: $ => choice(
      $._line_comment,
      $._block_comment
    ),
    _line_comment: $ => token(seq('//', /[\p{Any}&&[^\r\n]]*/)),
    _block_comment: $ => token(seq('/*', /[\p{Any}]*?/, '*/')),

    // 1.3 字面量
    literal: $ => choice(
      // 整数字面量 - 简化版本，确保能匹配100000u32
      /[0-9]+u32/,
      /[0-9]+u64/,
      /[0-9]+i32/,
      /[0-9]+i64/,
      /[0-9]+U32/,
      /[0-9]+U64/,
      /[0-9]+I32/,
      /[0-9]+I64/,
      /[0-9]+/,
      // 浮点数字面量
      /[0-9]+\.[0-9]+(f32|f64)?/,
      // 其他字面量
      $.rune_literal,
      $.boolean_literal,
      $.string_literal,
      $.unit_literal,
      $.nothing_literal,
      $.none_literal
    ),
    none_literal: $ => 'None',
    
    // 辅助规则，用于其他地方引用
    decimal_literal: $ => /[1-9][0-9_]*|[0]/,
    bin_digit: $ => /[01]/,
    octal_digit: $ => /[0-7]/,
    hex_digit: $ => /[0-9a-fA-F]/,
    integer_suffix: $ => choice('i8', 'i16', 'i32', 'i64', 'u8', 'u16', 'u32', 'u64', 'I8', 'I16', 'I32', 'I64', 'U8', 'U16', 'U32', 'U64'),
    decimal_fraction: $ => seq('.', /[0-9_]+/),
    decimal_fragment: $ => /[0-9_]+/,
    decimal_exponent: $ => seq(choice('e', 'E'), optional(choice('+', '-')), /[0-9_]+/),
    hex_fraction: $ => seq('.', repeat1(/[0-9a-fA-F]/)),
    hex_exponent: $ => seq(choice('p', 'P'), optional(choice('+', '-')), /[0-9_]+/),
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
      choice('"', "'"),
    ),
    line_string_content: $ => /[^"\\\r\n$]+|\\./,
    line_string_interpolation: $ => seq(
      '${',
      $.expression,
      '}'
    ),
    multi_line_string_literal: $ => seq(
      choice('"""', "'''"),
      /\r?\n/,
      repeat(choice($.multi_line_string_content, $.multi_line_string_interpolation)),
      choice('"""', "'''"),
    ),
    multi_line_string_content: $ => /[^"\\$]+|\\./,
    multi_line_string_interpolation: $ => seq(
      '${',
      $.expression,
      '}'
    ),
    

    // Unit 字面量（()）
    unit_literal: $ => '()',
    // Nothing 字面量（无显式字面量，通过上下文推断）
    nothing_literal: $ => 'Nothing',

    // 16. 常量求值（Constant Evaluation）
    // 常量表达式（简化版，用于编译时求值）
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
      $.range_constant_expression
    ),
    
    // 常量字面量（直接可求值的字面量）
    constant_literal: $ => $.literal,
    
    // 常量标识符（引用其他常量）
    constant_identifier: $ => $.identifier,
    
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
    type: $ => prec(16, choice(
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
    )),

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
      /(0b[01]+|0o[0-7]+|(0|[1-9][0-9_]*)|0x[0-9a-fA-F]+)/,
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
    
    // 指针类型（*T）
    pointer_type: $ => seq('*', $.type),
    
    // 类型标识符（引用已定义类型）
    type_identifier: $ => /[A-Z][a-zA-Z0-9_]*/,
    
    // 泛型类型（Type<T1, T2>）
    generic_type: $ => seq(
      $.type_identifier,
      '<',
      sep1($.type, ','),
      '>'
    ),

    // 类型参数引用（T）
    type_parameter_reference: $ => $.identifier,

    // 3. 变量与作用域（Variables & Scope）
    variable_declaration: $ => seq(
      optional($.annotation),
      repeat($.modifier),
      choice('let', 'var', 'const'),
      sep1(choice($.pattern, $.type_identifier), ','),
      optional(seq(':', $.type)),
      optional(seq('=', $.expression))
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
      '(',
      sep1($.pattern, ','),
      ')'
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
    expression: $ => $.assignment_expression,

    // 标识符表达式（变量/函数引用）
    identifier_expression: $ => choice(
      $.identifier,
      $.type_identifier
    ),
    
    // 括号表达式（(expr)）
    parenthesized_expression: $ => seq(
      '(',
      $.expression,
      ')'
    ),
    
    // 成员访问表达式（obj.member 或 Type.member）
    member_access_expression: $ => prec.left(15, seq(
      choice($.primary_expression, $.type),
      optional('?'),
      '.',
      $.identifier,
      optional($.type_arguments)
    )),
    type_arguments: $ => seq(
      '<',
      sep1($.type, ','),
      '>'
    ),
    
    // 函数调用表达式（func(arg1, arg2) 或 Type()）
    call_expression: $ => prec(15, seq(
      choice($.identifier, $.type_identifier, $.member_access_expression, $.primary_expression),
      optional('?'),
      '(',
      optional(sep1($.argument, ',')),
      ')'
    )),
    
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
      '[',
      sep1($.expression, ','),
      ']'
    ),
    
    // 主表达式（基本表达式类型）
    primary_expression: $ => choice(
      $.literal,
      $.identifier_expression,
      $.parenthesized_expression,
      $.member_access_expression,
      $.call_expression,
      $.index_access_expression,
      $.lambda_expression,
      $.numeric_conversion_expression
    ),
    
    // Lambda 表达式（{ x: T => expr } 或 { (x: T) => expr }）
    lambda_expression: $ => prec(15, seq(
      '{',
      optional($.lambda_parameters),
      '=>',
      repeat1($.expression_or_declaration),
      '}'
    )),
    lambda_parameters: $ => choice(
      // 单参数简化形式
      $.lambda_parameter,
      // 多参数形式
      seq('(', sep1($.lambda_parameter, ','), ')')
    ),
    lambda_parameter: $ => seq(
      $.identifier,
      optional(seq(':', $.type))
    ),
    
    // 数值转换表达式（T(expr)）
    numeric_conversion_expression: $ => seq(
      $.type,
      '(',
      $.expression,
      ')'
    ),
    
    // 一元表达式
    unary_expression: $ => choice(
      seq(choice('!', '-', '++', '--'), $.primary_expression),
      $.primary_expression
    ),
    
    // 幂运算表达式（right associative）
    exponentiation_expression: $ => choice(
      prec.right(14, seq(
        $.unary_expression,
        '**',
        $.exponentiation_expression
      )),
      $.unary_expression
    ),
    
    // 乘法表达式（left associative）
    multiplicative_expression: $ => choice(
      prec.left(13, seq(
        $.exponentiation_expression,
        choice('*', '/', '%'),
        $.multiplicative_expression
      )),
      $.exponentiation_expression
    ),
    
    // 加法表达式（left associative）
    additive_expression: $ => choice(
      prec.left(12, seq(
        $.multiplicative_expression,
        choice('+', '-'),
        $.additive_expression
      )),
      $.multiplicative_expression
    ),
    
    // 位移表达式（left associative）
    bitwise_shift_expression: $ => choice(
      prec.left(11, seq(
        $.additive_expression,
        choice('<<', '>>'),
        $.bitwise_shift_expression
      )),
      $.additive_expression
    ),
    
    // 关系表达式（non-associative）
    relational_expression: $ => choice(
      prec(10, seq(
        $.bitwise_shift_expression,
        choice('<', '<=', '>', '>='),
        $.bitwise_shift_expression
      )),
      $.bitwise_shift_expression
    ),
    
    // 相等性表达式（non-associative）
    equality_expression: $ => choice(
      prec(9, seq(
        $.relational_expression,
        choice('==', '!='),
        $.relational_expression
      )),
      $.relational_expression
    ),
    
    // 位与表达式（left associative）
    bitwise_and_expression: $ => choice(
      prec.left(8, seq(
        $.equality_expression,
        '&',
        $.bitwise_and_expression
      )),
      $.equality_expression
    ),
    
    // 位异或表达式（left associative）
    bitwise_xor_expression: $ => choice(
      prec.left(7, seq(
        $.bitwise_and_expression,
        '^',
        $.bitwise_xor_expression
      )),
      $.bitwise_and_expression
    ),
    
    // 位或表达式（left associative）
    bitwise_or_expression: $ => choice(
      prec.left(6, seq(
        $.bitwise_xor_expression,
        '|',
        $.bitwise_or_expression
      )),
      $.bitwise_xor_expression
    ),
    
    // 逻辑与表达式（left associative）
    logical_and_expression: $ => choice(
      prec.left(5, seq(
        $.bitwise_or_expression,
        '&&',
        $.logical_and_expression
      )),
      $.bitwise_or_expression
    ),
    
    // 逻辑或表达式（left associative）
    logical_or_expression: $ => choice(
      prec.left(4, seq(
        $.logical_and_expression,
        '||',
        $.logical_or_expression
      )),
      $.logical_and_expression
    ),
    
    // 空合并表达式（left associative）
    coalescing_expression: $ => choice(
      prec.left(3, seq(
        $.logical_or_expression,
        '??',
        $.coalescing_expression
      )),
      $.logical_or_expression
    ),
    
    // 流表达式（left associative）
    flow_expression: $ => choice(
      prec.left(2, seq(
        $.coalescing_expression,
        choice('|>', '~>'),
        $.flow_expression
      )),
      $.coalescing_expression
    ),
    
    // 赋值表达式（最低优先级，右结合）
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

    // 类型转换表达式（expr as T）
    type_cast_expression: $ => seq(
      $.expression,
      'as',
      $.type
    ),

    // 类型测试表达式（expr is T）
    type_test_expression: $ => seq(
      $.expression,
      'is',
      $.type
    ),

    // 控制转移表达式（return, break, continue）
    control_transfer_expression: $ => choice(
      $.return_expression,
      $.break_expression,
      $.continue_expression
    ),
    return_expression: $ => seq('return', optional($.expression)),
    break_expression: $ => seq('break', optional($.identifier)),
    continue_expression: $ => seq('continue', optional($.identifier)),
    
    // 代码块（包含多个表达式或声明）
    block: $ => seq(
      '{',
      repeat($.expression_or_declaration),
      '}'
    ),

    // 5. 函数（Functions）
    function_declaration: $ => choice(
      // 普通函数声明
      seq(
        optional($.annotation),
        repeat($.modifier),
        'func',
        $.identifier,
        optional($.type_parameters),
        $.function_parameters,
        optional(seq(':', $.type)),
        optional($.generic_constraints),
        $.block
      ),
      // main函数特殊处理，不需要func关键字
      seq(
        'main',
        $.function_parameters,
        optional(seq(':', $.type)),
        $.block
      )
    ),
    // 通用修饰符规则
    modifier: $ => choice(
      'public', 'private', 'protected', 'internal',
      'static', 'open', 'override', 'redef', 'mut', 'foreign', 'unsafe'
    ),
    type_parameters: $ => seq(
      '<',
      sep1($.type_parameter, ','),
      '>'
    ),
    type_parameter: $ => prec.left(1, seq(
      $.identifier,
      optional($.type_parameter_constraint)
    )),
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
      repeat($.modifier),
      'class',
      $.identifier,
      optional($.type_parameters),
      optional($.super_class_or_interfaces),
      optional($.generic_constraints),
      $.class_body
    ),
    super_class_or_interfaces: $ => seq(
      '<:',
      sep1($.type, '&')
    ),
    class_body: $ => seq(
      '{',
      optional($.class_primary_init),
      repeat($.class_member),
      '}'
    ),
    class_member: $ => choice(
      $.class_init,
      $.static_init,
      $.variable_declaration,
      $.function_declaration,
      $.operator_declaration,
      $.property_declaration,
      $.macro_invocation
    ),
    // 类主构造函数
    class_primary_init: $ => seq(
      optional($.class_member_modifier),
      $.identifier,
      '(',
      optional($.class_primary_init_params),
      ')',
      '{',
      optional($.this_call),
      repeat($.expression_or_declaration),
      '}'
    ),
    class_primary_init_params: $ => sep1($.class_primary_init_param, ','),
    class_primary_init_param: $ => choice(
      seq(
        optional($.class_member_modifier),
        choice('let', 'var'),
        $.identifier,
        ':',
        $.type
      ),
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
    // 类构造函数
    class_init: $ => seq(
      optional($.class_member_modifier),
      'init',
      '(',
      optional($.function_parameters),
      ')',
      '{',
      optional($.this_call),
      repeat($.expression_or_declaration),
      '}'
    ),
    // 静态初始化块
    static_init: $ => seq(
      'static',
      'init',
      '(',
      ')',
      '{',
      repeat($.expression_or_declaration),
      '}'
    ),
    // 类成员修饰符
    class_member_modifier: $ => choice('public', 'private', 'protected', 'internal'),
    // this 调用（用于构造函数）
    this_call: $ => seq('this', '(', optional(sep1($.argument, ',')), ')'),

    // 7. 结构体（Structs）
    struct_declaration: $ => seq(
      optional($.annotation),
      repeat($.modifier),
      'struct',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.struct_body
    ),
    struct_body: $ => seq(
      '{',
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
      repeat($.modifier),
      'enum',
      $.identifier,
      optional($.type_parameters),
      optional(seq('<:', sep1($.type, '&'))),
      optional($.generic_constraints),
      $.enum_body
    ),
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
      repeat($.modifier),
      'prop',
      $.identifier,
      ':',
      $.type,
      optional($.property_body)
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
      repeat($.modifier),
      'type',
      $.identifier,
      optional($.type_parameters),
      '=',
      $.type
    ),

    // 12. 操作符重载（Operator Overloading）
    operator_declaration: $ => seq(
      optional($.annotation),
      optional($.modifier),
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
      repeat($.modifier),
      'macro',
      $.identifier,
      optional($.type_parameters),
      $.function_parameters,
      optional(seq(':', $.type)),
      optional($.generic_constraints),
      $.block
    ),
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
