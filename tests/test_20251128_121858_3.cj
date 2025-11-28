/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_054

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
                 (varOrfuncDeclaration) of different types: String, Rune, Bool.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
//Test_case_1
    let string_01:String = "string_01;";
    let string_02:String = "string_02;";
    let stringValue_01:String =
        "${let stringVar1:String = string_01; var stringVar2:String = string_02; stringVar1 + " " + stringVar2}";
    let checkingString_01:String = "string_01; string_02;"
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"Test_case_1: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_2
    let stringValue_02:String = "${let charVar_01:Rune = '1'; var charVar_02:Rune = '2';charVar_01 != charVar_02}";
    let checkingString_02:String = "true"
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"Test_case_2: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_3
    let stringValue_03:String = "${let boolVar_01:Bool = true; boolVar_01}";
    let checkingString_03:String = "true"
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"Test_case_3: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_4
    let stringValue_04:String = "${var boolVar_02:Bool = false; boolVar_02;}";
    let checkingString_04:String = "false"
    Assert.equals(checkingString_04, stringValue_04, 
        reason:"Test_case_4: The single-line string(varOrfuncDeclaration) has incorrect value.");

    return 0;
}

