/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a04_011

  @Level:         1

  @Assertion:   2.1.1(4) Unsigned integer types include UInt8, UInt16, UInt32, UInt64 and
                UIntNative, which are types of unsigned integer values encoded with 8-bit,
                16-bit, 32-bit, 64-bit and platform dependent size, respectively.

  @Description: Checks that variable declared with unsigned integer type UInt8 can be assigned by 
                value '255' which takes 8 bits;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    let uintVar: UInt8 = 255;
    Assert.equals(255, uintVar, 
        reason:"""
A variable, declared with type UInt8
and assigned by value '255', has unexpected value.
""");

    return 0
}