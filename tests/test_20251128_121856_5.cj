/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a04_02

  @Level:         1

  @Assertion:    2.3.1(4) The conversion of Rune to UInt32 uses UInt32(e), where e is an expression of type Rune
                 and the result of UInt32(e) is the UInt32 value corresponding to the Unicode scalar value of e.

  @Description:  Check that conversion of non-unicode literal character to Uint32 causes a compilation error

  @Mode:         compileonly

  @Negative:     yes

*/

main(): Unit {
    var r1 = UInt32('\u{ffffffff}')
}
