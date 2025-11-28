/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a12_02

  @Level:         1

  @Assertion:    2.3.1(12) When a value is converted from a bigger type to a smaller type, if the value is beyond the
                 range of the smaller type, then the overflow strategy is determined by the attributed macro used in
                 the context (the default strategy is throwing exceptions), see Arithmetic Expressions for details of
                 the different overflow strategies

  @Description:  Check that when converting a value from a larger type to a smaller type, when the value is outside the
                 range of the lesser type, then the overflow strategy is executed (@OverflowThrowing as default)

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {
    let a12_02_01 = [8642_i16]
    let a12_02_02 = [3442523_i32]
    let a12_02_03 = [563483452_i64]
    let a12_02_04 = [IntNative(-37525)]
    let a12_02_05 = [-3572734_i32]
    let a12_02_06 = [362451334_i64]
    let a12_02_07 = [IntNative(-3762234)]
    let a12_02_08 = [3624561235323_i64]
    let a12_02_09 = [IntNative(-376225124523)]

    Assert.throws({ => Int8(a12_02_01[0]) },    check: { e => e is OverflowException})
    Assert.throws({ => Int8(a12_02_02[0]) },    check: { e => e is OverflowException})
    Assert.throws({ => Int8(a12_02_03[0]) },    check: { e => e is OverflowException})
    Assert.throws({ => Int8(a12_02_04[0]) },    check: { e => e is OverflowException})
    Assert.throws({ => Int16(a12_02_05[0]) },   check: { e => e is OverflowException})
    Assert.throws({ => Int16(a12_02_06[0]) },   check: { e => e is OverflowException})
    Assert.throws({ => Int16(a12_02_07[0]) },   check: { e => e is OverflowException})
    Assert.throws({ => Int32(a12_02_08[0]) },   check: { e => e is OverflowException})
    Assert.throws({ => Int32(a12_02_09[0]) },   check: { e => e is OverflowException})
}
