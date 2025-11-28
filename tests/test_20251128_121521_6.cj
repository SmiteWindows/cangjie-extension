/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a09_03

  @Level:         1
  @Assertion:   2.1.1.1(9) There are two forms of representation: decimal or hexadecimal. In the decimal representation, a floating-point number must contain an integer part or a fractional part.
  @Description: Check that floating-piont with only exponental part throws error (Float32)
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  let f16_1: Float32 = e6
  return 0
}