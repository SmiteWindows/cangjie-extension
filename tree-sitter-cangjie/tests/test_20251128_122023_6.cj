/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a05_06

  @Level:         1

  @Assertion:   2.1.1(5) Floating-point types include Float16, Float32, and Float64, which are
                types for floating-point numbers with encoding lengths of 16-bit, 32-bit, and
                64-bit, respectively.

  @Description: Checks that:
                - minimal value of Floating-point type Float64 takes 64 bits;
                - maximal value of Floating-point type Float64 takes less thah 64 bits;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    var f64Min1: Float64 = Float64.Min;
    var f64Min2: Float64 = -1.7976931348623157e308; // 0xFFEFFFFFFFFFFFFF
    Assert.equals(f64Min2, f64Min1, 
        reason: """
Test case 1: A variable, declared with type Float64
and assigned by minimal floating-point value of type Float64, 
has unexpected value.
""");

    //Test case 2
    var f64Max1: Float64 = Float64.Max;
    var f64Max2: Float64 = 1.7976931348623157e308; // 0x7FEFFFFFFFFFFFFF
    Assert.equals(f64Max2, f64Max1, 
        reason: """
Test case 2: A variable, declared with type Float64
and assigned by maximal floating-point value of type Float64, 
has unexpected value.
""");

    return 0;
}

