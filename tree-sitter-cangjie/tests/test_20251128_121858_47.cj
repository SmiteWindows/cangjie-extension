/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a15_01

  @Level:         1
  @Assertion:       2.1.1.2(15) Unary minus operator is denoted as -. The unary minus operator returns the negation of
                    its operand. For details about the unary minus operator, see Chapter 4.

  @Description:     Check that the unary minus operator works as expected for all possible types.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

main() {
    let i8: Int8 = 13
    Assert.equals(-13, -i8)
    let i16: Int16 = -11
    Assert.equals(11, -i16)
    let i32: Int32 = 14
    Assert.equals(-14, -i32)
    let i64: Int64 = -3
    Assert.equals(3, -i64)
    let i: IntNative = 15
    Assert.equals(-15, -i)

    let u8: UInt8 = 0
    Assert.equals(0, -u8)
    let u16: UInt16 = 0
    Assert.equals(0, -u16)
    let u32: UInt32 = 0
    Assert.equals(0, -u32)
    let u64: UInt64 = 0
    Assert.equals(0, -u64)
    let u: UIntNative = 0
    Assert.equals(0, -u)

    let f16: Float16 = 0.43
    Assert.approxEquals(-0.43, -f16)
    let f32: Float32 = -50.2695
    Assert.approxEquals(50.2695, -f32)
    let f64: Float64 = 0.9434234908390394
    Assert.approxEquals(-0.9434234908390394, -f64)

    Assert.equals(i8, -(-i8))
    Assert.equals(i16, -(-i16))
    Assert.equals(i32, -(-i32))
    Assert.equals(i64, -(-i64))
    Assert.equals(i, -(-i))
    Assert.equals(u8, -(-u8))
    Assert.equals(u16, -(-u16))
    Assert.equals(u32, -(-u32))
    Assert.equals(u64, -(-u64))
    Assert.equals(u, -(-u))

    Assert.approxEquals(f16, -(-f16))
    Assert.approxEquals(f32, -(-f32))
    Assert.approxEquals(f64, -(-f64))
}
