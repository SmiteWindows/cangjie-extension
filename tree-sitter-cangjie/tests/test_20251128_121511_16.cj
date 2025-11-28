/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a04_04

  @Level:         1

  @Assertion:    2.3.1(4) The conversion of Rune to UInt32 uses UInt32(e), where e is an expression of type Rune
                 and the result of UInt32(e) is the UInt32 value corresponding to the Unicode scalar value of e.

  @Description:  Check that initializing a Rune variable with an invalid value causes a runtime error

  @Mode:         run

  @Negative:     yes

*/

main(): Unit {

    let f: Rune = Rune(9999999999999)  // num is not a valid Unicode scalar value!
    var r1 = UInt32(f)
}
