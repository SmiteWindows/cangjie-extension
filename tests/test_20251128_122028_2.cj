/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a06_01

  @Level:         1
  @Assertion:       2.1.1.2(6) Explicit type conversion must be performed first to perform operations on operands with
                    different types.

  @Description:     Check that there are no errors after converting operands to one type.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         ** isn't checked because the power operator only allows different types (Int64 and UInt64). See
                    comment on issue 6166.
  @Issue:           0006166
*/

import utils.assert.Assert

main() {
    Assert.equals(2, 1i8 + Int8(1u16))
    Assert.equals(0, 1i8 - Int8(1i32))
    Assert.equals(1, 1i8 * Int8(1u8))
    Assert.equals(1, 1i8 / Int8(IntNative(1)))
    Assert.equals(0, 1i8 % Int8(1.0f64))

    Assert.equals(2, 1i16 + Int16(1.0f64))
    Assert.equals(0, 1i16 - Int16(1.0f32))
    Assert.equals(1, 1i16 * Int16(1i8))
    Assert.equals(1, 1i16 / Int16(IntNative(1)))
    Assert.equals(0, 1i16 % Int16(1.0f64))

    Assert.equals(2, 1i32 + Int32(1u16))
    Assert.equals(0, 1i32 - Int32(1u32))
    Assert.equals(1, 1i32 * Int32(1u16))
    Assert.equals(1, 1i32 / Int32(1u32))
    Assert.equals(0, 1i32 % Int32(1.0f32))

    Assert.equals(2, 1i64 + Int64(1u16))
    Assert.equals(0, 1i64 - Int64(1u32))
    Assert.equals(1, 1i64 * Int64(1u32))
    Assert.equals(1, 1i64 / Int64(1u64))
    Assert.equals(0, 1i64 % Int64(1.0f32))

    Assert.equals(2, IntNative(1) + IntNative(1.0f16))
    Assert.equals(0, IntNative(1) - IntNative(1u16))
    Assert.equals(1, IntNative(1) * IntNative(1i32))
    Assert.equals(1, IntNative(1) / IntNative(1i64))
    Assert.equals(0, IntNative(1) % IntNative(1i64))

    Assert.equals(2, 1u8 + UInt8(1u64))
    Assert.equals(0, 1u8 - UInt8(1u32))
    Assert.equals(1, 1u8 * UInt8(1u32))
    Assert.equals(1, 1u8 / UInt8(1u16))
    Assert.equals(0, 1u8 % UInt8(1.0f64))

    Assert.equals(2, 1u16 + UInt16(1u32))
    Assert.equals(0, 1u16 - UInt16(UIntNative(1)))
    Assert.equals(1, 1u16 * UInt16(1i8))
    Assert.equals(1, 1u16 / UInt16(1.0f64))
    Assert.equals(0, 1u16 % UInt16(1i64))

    Assert.equals(2, 1u32 + UInt32(1i32))
    Assert.equals(0, 1u32 - UInt32(1i8))
    Assert.equals(1, 1u32 * UInt32(1i8))
    Assert.equals(1, 1u32 / UInt32(1i32))
    Assert.equals(0, 1u32 % UInt32(1i32))

    Assert.equals(2, 1u64 + UInt64(1u32))
    Assert.equals(0, 1u64 - UInt64(1i64))
    Assert.equals(1, 1u64 * UInt64(1i32))
    Assert.equals(1, 1u64 / UInt64(IntNative(1)))
    Assert.equals(0, 1u64 % UInt64(1i16))

    Assert.equals(2, UIntNative(1) + UIntNative(1.0f16))
    Assert.equals(0, UIntNative(1) - UIntNative(1u16))
    Assert.equals(1, UIntNative(1) * UIntNative(1i32))
    Assert.equals(1, UIntNative(1) / UIntNative(1i64))
    Assert.equals(0, UIntNative(1) % UIntNative(1i64))

    Assert.approxEquals(2.0, 1.0f16 + Float16(1.0f32))
    Assert.approxEquals(0.0, 1.0f16 - Float16(UIntNative(1)))
    Assert.approxEquals(1.0, 1.0f16 * Float16(1i64))
    Assert.approxEquals(1.0, 1.0f16 / Float16(1u8))

    Assert.approxEquals(2.0, 1.0f32 + Float32(1u8))
    Assert.approxEquals(0.0, 1.0f32 - Float32(1i64))
    Assert.approxEquals(1.0, 1.0f32 * Float32(1u32))
    Assert.approxEquals(1.0, 1.0f32 / Float32(1i32))

    Assert.approxEquals(2.0, 1.0f64 + Float64(1u32))
    Assert.approxEquals(0.0, 1.0f64 - Float64(1i16))
    Assert.approxEquals(1.0, 1.0f64 * Float64(1u16))
    Assert.approxEquals(1.0, 1.0f64 / Float64(1i8))
}
