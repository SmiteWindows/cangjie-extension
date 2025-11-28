/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a27_01

  @Level:         1

  @Assertion:    2.3.1(27) When the integer part is beyond the range of the target type, an exception is thrown.

  @Description:  Check that If the integer part is out of range of the target type, an exception occurs.

  @Mode:         run

  @Negative:     no

  @Issue:        0006075

*/

import utils.assert.Assert

main(): Unit {
    Assert.throws({ => Int8(128.555_f16) },                         check: { e => e is OverflowException})
    Assert.throws({ => UInt8(-128.555_f32) },                       check: { e => e is OverflowException})
    Assert.throws({ => Int8(-129.555_f64) },                        check: { e => e is OverflowException})

    Assert.throws({ => Int16(42768.555_f16) },                      check: { e => e is OverflowException})
    Assert.throws({ => UInt16(-32769.555_f32) },                    check: { e => e is OverflowException})
    Assert.throws({ => Int16(-32769.555_f64) },                     check: { e => e is OverflowException})

    Assert.throws({ => Int32(Float16.Inf) },         check: { e => e is OverflowException})
    Assert.throws({ => UInt32(-3147483649.555_f32) },               check: { e => e is OverflowException})
    Assert.throws({ => Int32(-2147483649.555_f64) },                check: { e => e is OverflowException})

    Assert.throws({ => Int64(Float16.Inf) },         check: { e => e is OverflowException})
    Assert.throws({ => UInt64(Float32.Inf) },        check: { e => e is OverflowException})
    Assert.throws({ => Int64(-Float64.Inf) },         check: { e => e is OverflowException})

    Assert.throws({ => IntNative(Float16.Inf) },     check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(Float32.Inf) },    check: { e => e is OverflowException})
    Assert.throws({ => IntNative(-Float64.Inf) },     check: { e => e is OverflowException})
}