/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a19_02

  @Level:         1

  @Assertion:    2.3.1(19) Otherwise, determine the overflow strategy based on the attributed macro used in the context
                 (the default strategy is throwing exceptions), see Arithmetic Expressions for details of the different
                 overflow strategies.

  @Description:  Check that if the value is outside the range of the target type, the conversion will wrapping around 
                 at the numeric bounds of the type (@OverflowWrapping)

  @Mode:         run

  @Negative:     no

  @Issue:        0006274

*/

import utils.assert.Assert

@OverflowWrapping
main(): Unit {
    Assert.equals(255, UInt8(-1_i8))
    Assert.equals(0,   UInt8(256_i16))
    Assert.equals(1,   UInt8(257_i32))
    Assert.equals(255, UInt8(-1_i64))
    Assert.equals(255, UInt8(IntNative(-1)))

    Assert.equals(65409, UInt16(-127_i8))
    Assert.equals(32768, UInt16(-32768_i16))
    Assert.equals(0,     UInt16(65536_i32))
    Assert.equals(1,     UInt16(65537_i64))
    Assert.equals(38854, UInt16(IntNative(-3762234)))

    Assert.equals(4294967295, UInt32(-1_i8))
    Assert.equals(4294967294, UInt32(-2_i16))
    Assert.equals(4294967293, UInt32(-3_i32))
    Assert.equals(0,          UInt32(4294967296_i64))
    Assert.equals(1,          UInt32(IntNative(4294967297)))

    Assert.equals(18446744073709551615, UInt64(-1_i8))
    Assert.equals(18446744073709551614, UInt64(-2_i16))
    Assert.equals(18446744073709551613, UInt64(-3_i32))
    Assert.equals(9223372036854775808,  UInt64(-9223372036854775808_i64))

    Assert.equals(-128, Int8(128_u8))
    Assert.equals(0,    Int8(256_u16))
    Assert.equals(1,    Int8(257_u32))
    Assert.equals(127,  Int8(383_u64))
    Assert.equals(-127, Int8(UIntNative(129)))

    Assert.equals(-32768, Int16(32768_u16))
    Assert.equals(0,      Int16(65536_u32))
    Assert.equals(1,      Int16(65537_u64))
    Assert.equals(1,      Int16(UIntNative(327681)))

    Assert.equals(-2147483648, Int32(2147483648_u32))
    Assert.equals(-2147483648, Int32(10737418240_u64))
    Assert.equals(1,           Int32(UIntNative(4294967297)))

    Assert.equals(-9223372036854775808,  Int64(9223372036854775808_u64))
}
