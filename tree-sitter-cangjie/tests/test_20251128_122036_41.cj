/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a05_03

  @Level:         1

  @Assertion:   2.1.1(5) Floating-point types include Float16, Float32, and Float64, which are
                types for floating-point numbers with encoding lengths of 16-bit, 32-bit, and
                64-bit, respectively.

  @Description: Checks that:
                - variable declared with Floating-point type Float64 actually has type Float64
                  and can be assigned by positive, negative floating-point values and zero;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    let floarVar01: Float64 = 200.5;
    Assert.equals(true, floarVar01 is Float64, 
        reason: """
Test case 1: A variable, declared with type Float64
and assigned by positive floating-point value, has unexpected type.
""");

    //Test case 2
    Assert.equals(200.5, floarVar01, 
        reason: """
Test case 2: A variable, declared with type Float64
and assigned by positive floating-point value, has unexpected value.
""");

    //Test case 3
    let floarVar02: Float64 = -200.5;
    Assert.equals(true, floarVar02 is Float64, 
        reason: """
Test case 3: A variable, declared with type Float64
and assigned by negative floating-point value, has unexpected type.
""");

    //Test case 4
    Assert.equals(-200.5, floarVar02, 
        reason: """
Test case 4: A variable, declared with type Float64
and assigned by negative floating-point value, has unexpected value.
""");

    //Test case 5
    let floarVar03: Float64 = 0.0;
    Assert.equals(true, floarVar03 is Float64, 
        reason: """
Test case 5: A variable, declared with type Float64
and assigned by zero, has unexpected type.
""");

    //Test case 6
    Assert.equals(0.0, floarVar03, 
        reason: """
Test case 6: A variable, declared with type Float64
and assigned by zero, has unexpected value.
""");

    return 0;
}