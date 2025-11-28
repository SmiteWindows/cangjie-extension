/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_029

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

  @Description:  Checks that single-line string literal can be represented as lineStringExpression
                 ending with multiple semicolons which do not have any effect.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
    let stringValue:String = "${1 + 2;;;}";
    let checkingString:String = "3";
    Assert.equals(checkingString, stringValue, 
        reason:"The single-line string literal represented as lineStringExpression ending with some semicolons has " +
        "incorrect value:\n" + stringValue);
    return 0;
}

