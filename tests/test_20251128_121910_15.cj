/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_055

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
                 (varOrfuncDeclaration) of different types: Int8, Int16, Int32, Int64.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
//Test_case_1
    let stringValue_01:String = "${let int8Var_01:Int8 = 127; let int8Var_02:Int8 = 7; int8Var_01 - int8Var_02 + 1}";
    let checkingString_01:String = "121"
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"Test_case_1: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_2
    let stringValue_02:String =
        "${let int16Var_01:Int16 = 32767; let int16Var_02:Int16 = 32007; int16Var_01 - int16Var_02 + 1}";
    let checkingString_02:String = "761"
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"Test_case_2: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_3
    let stringValue_03:String =
        "${let int32Var_01:Int32 = -32769; let int32Var_02:Int32 = 9; int32Var_01 + int32Var_02}";
    let checkingString_03:String = "-32760"
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"Test_case_3: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_4
    let stringValue_04:String =
        "${let int64Var_01:Int64 = 65; let int64Var_02:Int64 = 2; int64Var_01 - int64Var_02 + 1}";
    let checkingString_04:String = "64"
    Assert.equals(checkingString_04, stringValue_04, 
        reason:"Test_case_4: The single-line string(varOrfuncDeclaration) has incorrect value.");

    return 0;
}

