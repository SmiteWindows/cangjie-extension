/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a14_01

  @Level:         1

  @Assertion:    2.3.1(14) Bidirectional conversion between unsigned integers: The rules are the same as conversion
                 between singed integers.

  @Description:  Check that the value is unchanged when it is converted from a smaller type to a bigger type for
                 unsigned integers

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let u8_u16 = UInt16(34_u8)
let u8_u32 = UInt32(35_u8)
let u8_u64 = UInt64(36_u8)
let u8_uN = UIntNative(37_u8)

var u16_u32 = UInt32(3572_u16)
var u16_u64 = UInt64(3624_u16)
var u16_uN = UIntNative(3762_u16)

var u32_u64 = UInt64(362456123_u32)
var u32_uN = UIntNative(376225124_u32)

main(): Unit {
    Assert.equals(34, u8_u16)
    Assert.equals(35, u8_u32)
    Assert.equals(36, u8_u64)
    Assert.equals(37, u8_uN)
    Assert.equals(3572, u16_u32)
    Assert.equals(3624, u16_u64)
    Assert.equals(3762, u16_uN)
    Assert.equals(362456123, u32_u64)
    Assert.equals(376225124, u32_uN)
}
