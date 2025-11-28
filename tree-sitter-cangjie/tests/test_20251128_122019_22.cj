/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a09_01

  @Level:         1

  @Assertion:    2.3.1(9) To convert a value or a numeric type to another numeric type, explicit type conversion must
                 be used. That is, numericType(expr) converts the value of expr to the numericType type.

  @Description:  Check that explicit type conversion is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

func f_u8() { return 7_u8 }
func f_uN(): UIntNative{ return 3807 }

main(): Unit {
    var a1 = 8_i8
    var a2: UInt16 = 8735
    var a3: IntNative = 8735890

    Assert.isTrue(UInt8(a1) is UInt8)
    Assert.isTrue(Int16(a2) is Int16)
    Assert.isTrue(UIntNative(a3) is UIntNative)
    Assert.isTrue(Int8(f_u8()) is Int8)
    Assert.isTrue(IntNative(f_uN()) is IntNative)
}
