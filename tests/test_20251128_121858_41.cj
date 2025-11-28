/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            01_03_06_a09_057

  @Level:         1

  @Assertion:       1.3.6(9) The syntax of the multi-line string literal is:
                       multiLineStringLiteral
                           : '"""' NL (multiLineStringExpression | multiLineStringContent)* '"""'
                           ;
                       multiLineStringExpression
                           : '${' end* (expressionOrDeclaration (end+ expressionOrDeclaration?)*) end* '}'
                           ;
                       multiLineStringContent
                           : MultiLineStrText
                           ;
                       MultiLineStrText
                           : ~('\\')
                           | EscapeSeq ;

  @Description:     Check that it is an error if declarations aren't separated by `end`.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
*/

main() {
    let a = """
        ${
            func f() {} func g() {}
        }
    """
}
