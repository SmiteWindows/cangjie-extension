/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a01_001

  @Level:         1

  @Assertion:   2.1.1(1) The numeric types are classified into integer types and floating-point
                types, which are used to represent integers and floating-point numbers,
                respectively.

  @Description: Checks that:
                - there is integer type using the 'Int32' type as an example;
                - there is floating-point type using the 'Float32' type as an example;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
//Test_case_1
    let integerVar: Int32 = 1;
    Assert.equals(true, integerVar is Int32, 
        reason:"""
Test_case_1: A variable, declared with type Int32, 
has actual type, different from Int32.
""");

//Test_case_2
    let floatingPointVar: Float32 = 1.0;
    Assert.equals(true, floatingPointVar is Float32, 
        reason:"""
Test_case_2: A variable, declared with type Float32, 
has actual type, different from Float32.
""");

    return 0
}