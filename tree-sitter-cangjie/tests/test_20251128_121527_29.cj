/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_016

  @Level:         1

  @Assertion:   1.3.6(4) The syntax of the single-line string literal is:
                    lineStringLiteral
                        : '"' (lineStringExpression | lineStringContent)* '"'
                        ;
                    lineStringExpression
                        : '${' SEMI* (expressionOrDeclaration (SEMI+ expressionOrDeclaration?)*) SEMI* '}'
                        ;
                    lineStringContent
                        : LineStrText
                        ;
                    LineStrText
                        : ~["\\\r\n]
                        | EscapeSeq ;

  @Description:  Checks that single-line string literal can be represented with UniCharacterLiteral 
                 with 1 HexadecimalDigit.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
    let stringValue:String = "single-line string literal with UniCharacterLiteral with 1 HexadecimalDigit: |\u{A}|";
    let checkingString:String = "single-line string literal with UniCharacterLiteral with 1 HexadecimalDigit: |" +
        "\u{A}" + "|";
    Assert.equals(checkingString, stringValue, 
        reason:"The single-line string literal with UniCharacterLiteral has incorrect value:\n" + stringValue);
    return 0;
}

