/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a17_03

  @Level:         1

  @Assertion:   2.1.1(17) Float32 See IEEE 754 binary32 format

  @Description: Checks that the result of operations under Float32 numbers is Float32.NaN 
                if it cannot be determined;

  @Mode:        run

  @Negative:    no

  @Structure:   single

  @Issue:       0006075


*/

import utils.assert.Assert

main() {
    //Test case 1
    var f32Var01: Float32 = Float32.Inf + -Float32.Inf;
    var isNaN01: Bool = false;
    try {
        // Expected: "OverflowException: Casting NaN value to integer."
        var i32: Int32 = Int32(f32Var01);
    } catch (e: OverflowException) {
        println(e)
        isNaN01 = e.toString()[19..35] == "Casting Infinite";
    } catch (e: Exception) {
    }

    Assert.equals(true, isNaN01, 
        reason: """
Test case 1: Result Of 'Add' operation 
with Float32 positive infinity and Float32 negative infinity
has value different from expected Float32.NaN.
""");

    //Test case 2
    var f32Var02: Float32 = 0.0 / 0.0;
    var isNaN02: Bool = false;
    try {
        var i32: Int32 = Int32(f32Var02);
    } catch (e: OverflowException) {
        isNaN02 = e.toString()[19..35] == "Casting Infinite";
    } catch (e: Exception) {
    }

    Assert.equals(true, isNaN02, 
        reason: """
Test case 2: Result Of 'Divide' operation 
with 0.0 and 0.0 has value different 
from expected Float32.NaN.
""");

    //Test case 3
    var f32Var03: Float32 = Float32.Inf / Float32.Inf;
    var isNaN03: Bool = false;
    try {
        var i32: Int32 = Int32(f32Var03);

    } catch (e: OverflowException) {
        isNaN03 = e.toString()[19..35] == "Casting Infinite";
    } catch (e: Exception) {
    }

    Assert.equals(true, isNaN03, 
        reason: """
Test case 3: Result Of 'Divide' operation 
with Float32 positive infinity and Float32 positive infinity
has value different from expected Float32.NaN.
""");

    return 0;
}

