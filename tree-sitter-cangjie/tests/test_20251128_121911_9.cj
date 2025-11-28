/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a05_05

  @Level:         1

  @Assertion:   2.1.1(5) Floating-point types include Float16, Float32, and Float64, which are
                types for floating-point numbers with encoding lengths of 16-bit, 32-bit, and
                64-bit, respectively.

  @Description: Checks that:
                - minimal value of Floating-point type Float32 takes 32 bits;
                - maximal value of Floating-point type Float32 takes less thah 32 bits;

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

    return 0;
}

