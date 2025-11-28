/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a14_04

  @Level:         1

  @Assertion:    2.3.1(14) Bidirectional conversion between unsigned integers: The rules are the same as conversion
                 between singed integers.

  @Description:  Check that when converting a value from a larger type to a smaller type, when the value is outside the
                 range of the lesser type, then the overflow strategy is executed (@OverflowWrapping)

  @Mode:         run

  @Negative:     no

  @Issue:       0006274

*/

import utils.assert.Assert

@OverflowWrapping
main(): Unit {
    Assert.equals(194, UInt8(8642_u16))
    Assert.equals(91, UInt8(3442523_u32))
    Assert.equals(60, UInt8(563483452_u64))
    Assert.equals(149, UInt8(UIntNative(37525)))
    Assert.equals(33790, UInt16(3572734_u32))
    Assert.equals(37254, UInt16(362451334_u64))
    Assert.equals(26682, UInt16(UIntNative(3762234)))
    Assert.equals(3903804795, UInt32(3624561235323_u64))
    Assert.equals(2562969771, UInt32(UIntNative(376225124523)))
}
