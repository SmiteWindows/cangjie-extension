/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a05_03

  @Level:         1

  @Assertion:    2.3.1(5) The conversion of an integer type to Rune is done by means of Rune(num), where num can be of
                 any integer type, and only if the value of num falls in [0x0000, 0xD7FF] or [0xE000, 0x10FFFF] 
                 (i.e., the Unicode scalar value), the character represented by the corresponding Unicode scalar value
                 is returned; otherwise, a compile error (the value of num can be determined at compile time) is
                 generated or a runtime exception is thrown.

  @Description:  Check that conversion to Rune from Int8 value outside Unicode scalar values leads to 
                 runtime exception.

  @Mode:         run

  @Negative:     yes

*/

main(): Unit {
    let r1 = Rune(-1_i8)
}
