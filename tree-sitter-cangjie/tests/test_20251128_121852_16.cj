/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a03_006

  @Level:         1

  @Assertion:   2.1.1(3) Signed integer types include Int8, Int16, Int32, Int64 and IntNative,
                which are used to represent types of signed integer values whose lengths are
                8-bit, 16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that variable declared with signed integer type Int8 can be assigned by 
                  negativer value '-128' which takes 8 bits;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    let intVar: Int8 = -128;
    Assert.equals(-128, intVar, 
        reason:"""
A variable, declared with type Int8
and assigned by negative integer value '-128', has unexpected value.
""");

    return 0
}