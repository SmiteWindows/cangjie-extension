/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a12_04

  @Level:         1

  @Assertion:    2.3.1(12) When a value is converted from a bigger type to a smaller type, if the value is beyond the
                 range of the smaller type, then the overflow strategy is determined by the attributed macro used in
                 the context (the default strategy is throwing exceptions), see Arithmetic Expressions for details of
                 the different overflow strategies

  @Description:  Check that when converting a value from a larger type to a smaller type, when the value is outside the
                 range of the lesser type, then the overflow strategy is executed (@OverflowSaturating)

  @Mode:         run

  @Negative:     no

  @Issue:        0006274 0006312

*/

import utils.assert.Assert

@OverflowSaturating
main(): Unit {
    Assert.equals(127, Int8(8642_i16))
    Assert.equals(-128, Int8(-3442523_i32))
    Assert.equals(127, Int8(563483452_i64))
    Assert.equals(-128, Int8(IntNative(-37525)))
    Assert.equals(-32768, Int16(-3572734_i32))
    Assert.equals(32767, Int16(362451334_i64))
    Assert.equals(-32768, Int16(IntNative(-3762234)))
    Assert.equals(2147483647, Int32(3624561235323_i64))
    Assert.equals(-2147483648, Int32(IntNative(-376225124523)))
}
