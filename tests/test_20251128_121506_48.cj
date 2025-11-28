/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a04_007

  @Level:         1

  @Assertion:   2.1.1(4) Unsigned integer types include UInt8, UInt16, UInt32, UInt64 and
                UIntNative, which are types of unsigned integer values encoded with 8-bit,
                16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that variable declared with unsigned integer type UInt64 actually has type UInt64
                and can be assigned by positive value and zero;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
//Test_case_1
    let uintVar_01: UInt64 = 8446744073709551614;
    Assert.equals(true, uintVar_01 is UInt64, 
        reason:"""
Test_case_1: A variable, declared with type UInt64
and assigned by positive integer value, has unexpected type.
""");

//Test_case_2
    Assert.equals(8446744073709551614, uintVar_01, 
        reason:"""
Test_case_2: A variable, declared with type UInt64
and assigned by positive integer value, has unexpected value.
""");

//Test_case_3
    let uintVar_02: UInt64 = 0;
    Assert.equals(true, uintVar_02 is UInt64, 
        reason:"""
Test_case_3: A variable, declared with type UInt64
and assigned by zero, has unexpected type.
""");

//Test_case_4
    Assert.equals(0, uintVar_02, 
        reason:"""
Test_case_6: A variable, declared with type UInt64
and assigned by zero, has unexpected value.
""");

    return 0
}

