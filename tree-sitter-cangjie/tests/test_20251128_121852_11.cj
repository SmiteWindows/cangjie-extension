/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_057

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
                 (varOrfuncDeclaration) of different types: Float16, Float32, Float64.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
//Test_case_1
    let stringValue_01:String =
        "${let float16Var_01:Float16 = 1.5; let float16Var_02:Float16 = 2.5; float16Var_01 + float16Var_02}";
    let checkingString_01:String = "4.000000"
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"Test_case_1: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_2
    let stringValue_02:String =
        "${let float32Var_01:Float32 = 100.5; let float32Var_02:Float32 = 2.5; float32Var_01 + float32Var_02}";
    let checkingString_02:String = "103.000000"
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"Test_case_2: The single-line string(varOrfuncDeclaration) has incorrect value.");

//Test_case_3
    let stringValue_03:String =
        "${let float64Var_01:Float64 = 200.5; let float64Var_02:Float64 = 3.5; float64Var_01 + float64Var_02}";
    let checkingString_03:String = "204.000000"
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"Test_case_3: The single-line string(varOrfuncDeclaration) has incorrect value.");

    return 0;
}

