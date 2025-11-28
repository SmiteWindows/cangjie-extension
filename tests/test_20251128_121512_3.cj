/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_a03_001

  @Level:         1

  @Assertion:   1.3(3) The syntax of literal is defined as follows.
                   literalConstant
                       : IntegerLiteral
                       | FloatLiteral
                       | CharacterLiteral
                       | booleanLiteral
                       | stringLiteral
                       ;

                   stringLiteral
                       : lineStringLiteral
                       | multiLineStringLiteral
                       | MultiLineRawStringLiteral
                       ;

  @Description:  Checks that valid literalConstant can be assigned to variable
                 and that variable has correct type and value.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

main(){

//Test case N1
    let var_01 = 5i8;
    Assert.equals(true, var_01 is Int8, 
        reason:"Test case N1: the variable assigned by Int8 literal has incorrect type");
    let checkingValue_01:Int8 = 2i8 + 3i8;
    Assert.equals(checkingValue_01, var_01, 
        reason:"""
Test case N1: The variable assigned by Int8 literal has incorrect value: ${var_01} """);

//Test case N2
    let var_02 = 6u8;
    Assert.equals(true, var_02 is UInt8, 
        reason:"Test case N2: the variable assigned by UInt8 literal has incorrect type");
    let checkingValue_02:UInt8 = 3 + 3;
    Assert.equals(checkingValue_02, var_02, 
        reason:"""
Test case N2: The variable assigned by UInt8 literal has incorrect value: ${var_02} """);

//Test case N3
    let var_03 = 16i16;
    Assert.equals(true, var_03 is Int16, 
        reason:"Test case N3: the variable assigned by Int16 literal has incorrect type");
    let checkingValue_03:Int16 = 15 + 1;
    Assert.equals(checkingValue_03, var_03, 
        reason:"""
Test case N3: The variable assigned by UInt8 literal has incorrect value: ${var_03} """);

//Test case N3
    let var_04 = 15u16;
    Assert.equals(true, var_04 is UInt16, 
        reason:"Test case N4: the variable assigned by Int16 literal has incorrect type");
    let checkingValue_04:UInt16 = 14 + 1;
    Assert.equals(checkingValue_04, var_04, 
        reason:"""
Test case N4: The variable assigned by UInt8 literal has incorrect value: ${var_04} """);

    return 0;
}




