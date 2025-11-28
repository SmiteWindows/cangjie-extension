/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_017

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
                 with 2 HexadecimalDigits.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
    let stringValue:String = "single-line string literal with UniCharacterLiteral with 2 HexadecimalDigits: |\u{23}|";
    let checkingString:String = "single-line string literal with UniCharacterLiteral with 2 HexadecimalDigits: |" +
        "\u{23}" + "|";
    Assert.equals(checkingString, stringValue, 
        reason:"The single-line string literal with UniCharacterLiteral has incorrect value:\n" + stringValue);
    return 0;
}

