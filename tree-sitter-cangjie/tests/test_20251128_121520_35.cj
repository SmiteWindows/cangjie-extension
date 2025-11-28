
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a36_01

  @Level:         1

  @Assertion:    2.3.1(36) In addition, when the value of a floating point number is NaN, POSITIVE_INFINITY, 
                 or NEGATIVE_INFINITY, an exception is thrown the behavior is undefined when it is converted 
                 to an unsigned integer.

  @Description:  Check that if the floating-point number value is NaN, POSITIVE_INFINITY or NEGATIVE_INFINITY,
                 an exception occurs when converting it to a unsigned integer.

  @Mode:         run

  @Negative:     no

  @Issue:        0006075

*/

import utils.assert.Assert

main(): Unit {
    Assert.throws({ => UInt8(Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(-Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(Float16.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt8(Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(-Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(Float32.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt8(Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(-Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt8(Float64.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt16(Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(-Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(Float16.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt16(Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(-Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(Float32.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt16(Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(-Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt16(Float64.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt32(Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(-Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(Float16.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt32(Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(-Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(Float32.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt32(Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(-Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt32(Float64.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt64(Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(-Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(Float16.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt64(Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(-Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(-Float32.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UInt64(Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(-Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UInt64(Float64.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UIntNative(Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(-Float16.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(Float16.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UIntNative(Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(-Float32.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(Float32.NaN) }, check: { e => e is OverflowException})

    Assert.throws({ => UIntNative(Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(-Float64.Inf) }, check: { e => e is OverflowException})
    Assert.throws({ => UIntNative(Float64.NaN) }, check: { e => e is OverflowException})
}