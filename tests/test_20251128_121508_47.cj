/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a04_098

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
                 (varOrfuncDeclaration) of different types (Float16, Float32, Float64),
                 containing calls of functions of corresponding type.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  
*/

import utils.assert.*

main(){
//Test_case_1
    let float16Var_01:Float16 = 1.5;
    let float16Var_02:Float16 = 2.5;
    let stringValue_01:String =
        "${func getFloat16(p:Float16):Float16{return p;}; getFloat16(float16Var_01) + getFloat16(float16Var_02)}";
    let checkingString_01:String = "4.000000"
    Assert.equals(checkingString_01, stringValue_01, 
        reason:"Test_case_1: The single-line string has incorrect value.");


//Test_case_2
    let float32Var_01:Float32 = 100.5;
    let float32Var_02:Float32 = 2.5;
    let stringValue_02:String =
        "${func getFloat32(p:Float32):Float32{return p;}; getFloat32(float32Var_01) + getFloat32(float32Var_02)}";
    let checkingString_02:String = "103.000000"
    Assert.equals(checkingString_02, stringValue_02, 
        reason:"Test_case_2: The single-line string has incorrect value.");

//Test_case_3
    let float64Var_01:Float64 = 200.5;
    let float64Var_02:Float64 = 3.5;
    let stringValue_03:String =
        "${func getFloat64(p:Float64):Float64{return p;}; getFloat64(float64Var_01) + getFloat64(float64Var_02)}";
    let checkingString_03:String = "204.000000"
    Assert.equals(checkingString_03, stringValue_03, 
        reason:"Test_case_3: The single-line string has incorrect value.");

    return 0;
}

