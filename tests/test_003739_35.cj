/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a09_02

  @Level:         1

  @Assertion:    2.3.1(9) To convert a value or a numeric type to another numeric type, explicit type conversion must
                 be used. That is, numericType(expr) converts the value of expr to the numericType type.

  @Description:  Check that converting a UInt8 type to UIn16 type without using an explicit type conversion
                 causes a compilation error

  @Mode:         compileonly

  @Negative:     yes

*/

func f_u8() { return 7_u8 }

main(): Unit {
    var a2: UInt16 = f_u8()
}
