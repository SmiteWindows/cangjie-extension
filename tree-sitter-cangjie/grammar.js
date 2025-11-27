// tree-sitter-cangjie/grammar.js
// Cangjie语言的Tree-sitter语法定义

export default grammar({
  name: 'cangjie',

  extras: $ => [
    /\s/,
    $.comment
  ],

  rules: {
    // 程序入口
    source_file: $ => repeat($._definition),

    // 定义（函数、变量、类型等）
    _definition: $ => choice(
      $.function_definition,
      $.variable_declaration,
      $.struct_definition,
      $.enum_definition,
      $.interface_definition,
      $.module_declaration,
      $.import_statement
    ),

    // 函数定义
    function_definition: $ => seq(
      optional('pub'),
      'fn',
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      optional(seq('->', field('return_type', $._type))),
      field('body', $.block)
    ),

    // 参数列表
    parameter_list: $ => seq(
      '(',
      commaSep($.parameter),
      ')'
    ),

    parameter: $ => seq(
      field('name', $.identifier),
      ':',
      field('type', $._type)
    ),

    // 变量声明
    variable_declaration: $ => seq(
      optional('pub'),
      choice('let', 'var'),
      field('name', $.identifier),
      optional(seq(':', field('type', $._type))),
      optional(seq('=', field('value', $._expression)))
    ),

    // 结构体定义
    struct_definition: $ => seq(
      optional('pub'),
      'struct',
      field('name', $.identifier),
      field('fields', $.field_list)
    ),

    field_list: $ => seq(
      '{',
      commaSep($.field),
      '}'
    ),

    field: $ => seq(
      optional('pub'),
      field('name', $.identifier),
      ':',
      field('type', $._type)
    ),

    // 枚举定义
    enum_definition: $ => seq(
      optional('pub'),
      'enum',
      field('name', $.identifier),
      '{',
      commaSep($.enum_variant),
      '}'
    ),

    enum_variant: $ => seq(
      field('name', $.identifier),
      optional(seq('=', field('value', $._expression)))
    ),

    // 接口定义
    interface_definition: $ => seq(
      optional('pub'),
      'interface',
      field('name', $.identifier),
      '{',
      repeat($.interface_method),
      '}'
    ),

    interface_method: $ => seq(
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      optional(seq('->', field('return_type', $._type)))
    ),

    // 模块声明
    module_declaration: $ => seq(
      'module',
      field('name', $.identifier)
    ),

    // 导入语句
    import_statement: $ => seq(
      'import',
      field('path', $.import_path)
    ),

    import_path: $ => seq(
      $.identifier,
      repeat(seq('.', $.identifier))
    ),

    // 代码块
    block: $ => seq(
      '{',
      repeat($._statement),
      '}'
    ),

    // 语句
    _statement: $ => choice(
      $.expression_statement,
      $.assignment_statement,
      $.return_statement,
      $.if_statement,
      $.for_statement,
      $.while_statement,
      $.break_statement,
      $.continue_statement
    ),

    expression_statement: $ => seq($._expression, ';'),

    assignment_statement: $ => seq(
      field('left', $._expression),
      '=',
      field('right', $._expression),
      ';'
    ),

    return_statement: $ => seq('return', optional($._expression), ';'),

    if_statement: $ => seq(
      'if',
      field('condition', $._expression),
      field('consequence', $.block),
      optional(seq('else', field('alternative', $.block)))
    ),

    for_statement: $ => seq(
      'for',
      field('variable', $.identifier),
      'in',
      field('iterable', $._expression),
      field('body', $.block)
    ),

    while_statement: $ => seq(
      'while',
      field('condition', $._expression),
      field('body', $.block)
    ),

    break_statement: $ => seq('break', ';'),
    continue_statement: $ => seq('continue', ';'),

    // 表达式
    _expression: $ => choice(
      $.identifier,
      $.string,
      $.number,
      $.boolean,
      $.function_call,
      $.field_access,
      $.array_access,
      $.binary_expression,
      $.unary_expression,
      $.parenthesized_expression
    ),

    function_call: $ => seq(
      field('function', $._expression),
      field('arguments', $.argument_list)
    ),

    argument_list: $ => seq(
      '(',
      commaSep($._expression),
      ')'
    ),

    field_access: $ => prec.left(seq($._expression, '.', $.identifier)),

    array_access: $ => seq($._expression, '[', $._expression, ']'),

    binary_expression: $ => choice(
      ...[
        ['+', 'left'],
        ['-', 'left'],
        ['*', 'left'],
        ['/', 'left'],
        ['%', 'left'],
        ['==', 'left'],
        ['!=', 'left'],
        ['<', 'left'],
        ['<=', 'left'],
        ['>', 'left'],
        ['>=', 'left'],
        ['&&', 'left'],
        ['||', 'left'],
      ].map(([op, assoc]) =>
        prec[assoc](seq(field('left', $._expression), op, field('right', $._expression)))
      )
    ),

    unary_expression: $ => prec.right(seq(choice('-', '!'), $._expression)),

    parenthesized_expression: $ => seq('(', $._expression, ')'),

    // 基本类型
    _type: $ => choice(
      $.identifier,
      $.array_type,
      $.function_type
    ),

    array_type: $ => seq('[', $._type, ']'),

    function_type: $ => seq(
      $.parameter_list,
      '->',
      $._type
    ),

    // 基本元素
    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    string: $ => choice(
      seq('"', /[^"\\]*(\\.[^"\\]*)*"/),
      seq("'", /[^'\\]*(\\.[^'\\]*)*"/)
    ),

    number: $ => /0|[1-9][0-9]*|0x[0-9a-fA-F]+|0b[01]+/,

    boolean: $ => choice('true', 'false'),

    comment: $ => choice(
      // 单行注释
      token(seq('//', /.*/)),
      // 多行注释
      token(seq('/*', /[^*]*\*+([^/*][^*]*\*+)*/, '/'))
    ),
  }
});

function commaSep(rule) {
  return optional(commaSep1(rule));
}

function commaSep1(rule) {
  return seq(
    rule,
    repeat(seq(',', rule)),
    optional(',')
  );
}
