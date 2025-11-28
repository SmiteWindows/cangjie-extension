/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a03_004

  @Level:         1

  @Assertion:   2.1.1(3) Signed integer types include Int8, Int16, Int32, Int64 and IntNative,
                which are used to represent types of signed integer values whose lengths are
                8-bit, 16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that:
                - variable declared with signed integer type Int64 actually has type Int64
                  and can be assigned by positive, negative integer values and zero;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
//Test_case_1
    let intVar_01: Int64 = 9223372036854775000;
    Assert.equals(true, intVar_01 is Int64, 
        reason:"""
Test_case_1: A variable, declared with type Int64
and assigned by positive integer value, has unexpected type.
""");

//Test_case_2
    Assert.equals(9223372036854775000, intVar_01, 
        reason:"""
Test_case_2: A variable, declared with type Int64
and assigned by positive integer value, has unexpected value.
""");

//Test_case_3
    let intVar_02: Int64 = -9223372036854775000;
    Assert.equals(true, intVar_02 is Int64, 
        reason:"""
Test_case_3: A variable, declared with type Int64
and assigned by negative integer value, has unexpected type.
""");

//Test_case_4
    Assert.equals(-9223372036854775000, intVar_02, 
        reason:"""
Test_case_4: A variable, declared with type Int64
and assigned by negative integer value, has unexpected value.
""");

//Test_case_5
    let intVar_03: Int64 = 0;
    Assert.equals(true, intVar_03 is Int64, 
        reason:"""
Test_case_5: A variable, declared with type Int64
and assigned by zero, has unexpected type.
""");

//Test_case_6
    Assert.equals(0, intVar_03, 
        reason:"""
Test_case_6: A variable, declared with type Int64
and assigned by zero, has unexpected value.
""");

    return 0
}