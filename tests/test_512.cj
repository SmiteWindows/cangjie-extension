/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a17_01

  @Level:         1

  @Assertion:   2.1.1(17) Float32 See IEEE 754 binary32 format

  @Description: Checks that various values of Floating-point type Float32,
                including Float32 minimal and maximal values, have length 
                not greater than 32 bits;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    var f32Min1: Float32 = Float32.Min;
    var f32Min2: Float32 = -3.4028234664e38; //0xFF7FFFFF
    Assert.equals(f32Min2, f32Min1, 
        reason: """
Test case 1: A variable, declared with type Float32
and assigned by minimal floating-point value of type Float32, 
has unexpected value.
""");

    //Test case 2
    var f32Max1: Float32 = Float32.Max;
    var f32Max2: Float32 = 3.4028234664e38; //0x7F7FFFFF
    Assert.equals(f32Max2, f32Max1, 
        reason: """
Test case 2: A variable, declared with type Float32
and assigned by maximal floating-point value of type Float32, 
has unexpected value.
""");

    //Test case 3
    var f32Var31: Float32 = 1000000000.0;
    var f32Var32: Float32 = 1.0E9; // 0x4E6E6B28
    Assert.equals(f32Var32, f32Var31, 
        reason: """
Test case 3: A variable, declared with type Float32
and assigned by some positive floating-point value of type Float32, 
has unexpected value.
""");

    //Test case 4
    var f32Var41: Float32 = -1000000000.0;
    var f32Var42: Float32 = -1.0E9; // 0xCE6E6B28
    Assert.equals(f32Var42, f32Var41, 
        reason: """
Test case 4: A variable, declared with type Float32
and assigned by some negative floating-point value of type Float32, 
has unexpected value.
""");

    return 0;
}

