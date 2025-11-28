/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a12_01

  @Level:         1
  @Assertion:       2.1.1.2(12) Self-increment/decrement operators include the self-increment (++) and
                    self-decrement (--). These can be regarded as special assignment operator, using for adding or
                    subtracting 1 for the variable.

  @Description:     Check that the listed operators work as expected for all possible types.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

main() {
    // Check ++ and -- for different types
    var i64 = 99999
    i64++
    Assert.equals(100000, i64)
    i64--
    Assert.equals(99999, i64)

    var u64: UInt64 = 9999
    u64++
    Assert.equals(10000, u64)
    u64--
    Assert.equals(9999, u64)

    var i32: Int32 = 999
    i32++
    Assert.equals(1000, i32)
    i32--
    Assert.equals(999, i32)

    var u32: UInt32 = 99
    u32++
    Assert.equals(100, u32)
    u32--
    Assert.equals(99, u32)

    var i16: Int16 = 9
    i16--
    Assert.equals(8, i16)
    i16++
    Assert.equals(9, i16)

    var u16: UInt16 = 1
    u16--
    Assert.equals(0, u16)
    u16++
    Assert.equals(1, u16)

    var i8: Int8 = -9
    i8--
    Assert.equals(-10, i8)
    i8++
    Assert.equals(-9, i8)

    var u8: UInt8 = 2
    u8--
    Assert.equals(1, u8)
    u8++
    Assert.equals(2, u8)

    var i: IntNative = -99
    i--
    Assert.equals(-100, i)
    i++
    Assert.equals(-99, i)

    var u: UIntNative = 31
    u--
    Assert.equals(30, u)
    u++
    Assert.equals(31, u)

    // Check that ++ is equal to += and -- is equal to -=
    var w64_1 = 0
    var w64_2 = w64_1
    w64_1++
    w64_2 += 1
    Assert.equals(w64_2, w64_1)
    w64_1--
    w64_2 -= 1
    Assert.equals(w64_2, w64_1)

    var w64u_1: UInt64 = 1
    var w64u_2 = w64u_1
    w64u_1++
    w64u_2 += 1
    Assert.equals(w64u_2, w64u_1)
    w64u_1--
    w64u_2 -= 1
    Assert.equals(w64u_2, w64u_1)

    var w32i_1: Int32 = 2
    var w32i_2 = w32i_1
    w32i_1++
    w32i_2 += 1
    Assert.equals(w32i_2, w32i_1)
    w32i_1--
    w32i_2 -= 1
    Assert.equals(w32i_2, w32i_1)

    var w32u_1: UInt32 = 3
    var w32u_2 = w32u_1
    w32u_1++
    w32u_2 += 1
    Assert.equals(w32u_2, w32u_1)
    w32u_1--
    w32u_2 -= 1
    Assert.equals(w32u_2, w32u_1)

    var w16i_1: Int16 = 26
    var w16i_2 = w16i_1
    w16i_1++
    w16i_2 += 1
    Assert.equals(w16i_2, w16i_1)
    w16i_1--
    w16i_2 -= 1
    Assert.equals(w16i_2, w16i_1)

    var w16u_1: UInt16 = 36
    var w16u_2 = w16u_1
    w16u_1++
    w16u_2 += 1
    Assert.equals(w16u_2, w16u_1)
    w16u_1--
    w16u_2 -= 1
    Assert.equals(w16u_2, w16u_1)

    var w8i_1: Int16 = 113
    var w8i_2 = w8i_1
    w8i_1++
    w8i_2 += 1
    Assert.equals(w8i_2, w8i_1)
    w8i_1--
    w8i_2 -= 1
    Assert.equals(w8i_2, w8i_1)

    var w8u_1: UInt16 = 33
    var w8u_2 = w8u_1
    w8u_1++
    w8u_2 += 1
    Assert.equals(w8u_2, w8u_1)
    w8u_1--
    w8u_2 -= 1
    Assert.equals(w8u_2, w8u_1)

    var wi_1: IntNative = 113
    var wi_2 = wi_1
    wi_1++
    wi_2 += 1
    Assert.equals(wi_2, wi_1)
    wi_1--
    wi_2 -= 1
    Assert.equals(wi_2, wi_1)

    var wu_1: UIntNative = 33
    var wu_2 = wu_1
    wu_1++
    wu_2 += 1
    Assert.equals(wu_2, wu_1)
    wu_1--
    wu_2 -= 1
    Assert.equals(wu_2, wu_1)
}
