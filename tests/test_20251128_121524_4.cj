/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_a03_004

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
    let var_01 = r'A';
    Assert.equals(true, var_01 is Rune, 
        reason:"Test case N1: the variable assigned by Rune literal has incorrect type");
    let checkingValue_01:Rune = r'\u{41}';
    Assert.equals(checkingValue_01, var_01, 
        reason:"""
Test case N1: The variable assigned by Rune literal has incorrect value: ${var_01} """);

//Test case N2
    let var_02 = true;
    Assert.equals(true, var_02 is Bool, 
        reason:"Test case N2: the variable assigned by Bool literal has incorrect type");
    Assert.equals(1 == 1, var_02, 
        reason:"""
Test case N2: The variable assigned by Bool literal has incorrect value: ${var_02} """);

//Test case N3
    let var_03 = false;
    Assert.equals(true, var_03 is Bool, 
        reason:"Test case N3: the variable assigned by Bool literal has incorrect type");
    Assert.equals(1 != 1, var_03, 
        reason:"""
Test case N3: The variable assigned by Bool literal has incorrect value: ${var_03} """);

    return 0;
}

