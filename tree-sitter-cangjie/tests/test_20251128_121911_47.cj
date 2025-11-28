/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a16_01

  @Level:         1

  @Assertion:   2.1.1(16) Float16 See IEEE 754 binary16 format

  @Description: Checks that various values of Floating-point type Float16,
                including Float16 minimal and maximal values, have length 
                not greater than 16 bits;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    var f16Min1: Float16 = Float16.Min;
    var f16Min2: Float16 = -6.55e4; // 0xFBFF
    Assert.equals(f16Min2, f16Min1, 
        reason: """
Test case 1: A variable, declared with type Float16
and assigned by minimal floating-point value of type Float16, 
has unexpected value.
""");

    //Test case 2
    var f16Max1: Float16 = Float16.Max;
    var f16Max2: Float16 = 6.55e4; // 0x7BFF
    Assert.equals(f16Max2, f16Max1, 
        reason: """
Test case 2: A variable, declared with type Float16
and assigned by maximal floating-point value of type Float16, 
has unexpected value.
""");

    //Test case 3
    var f16Var31: Float16 = 65472.0;
    var f16Var32: Float16 = 6.547E4; // 0x7BFE
    Assert.equals(f16Var32, f16Var31, 
        reason: """
Test case 3: A variable, declared with type Float16
and assigned by some positive floating-point value of type Float16, 
has unexpected value.
""");

    //Test case 4
    var f16Var41: Float16 = -65472.0;
    var f16Var42: Float16 = -6.547E4; // 0xFBFE
    Assert.equals(f16Var42, f16Var41, 
        reason: """
Test case 4: A variable, declared with type Float16
and assigned by some negative floating-point value of type Float16, 
has unexpected value.
""");

    return 0;
}

