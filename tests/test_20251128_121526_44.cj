/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a08_06

  @Level:         1
  @Assertion:   2.1.1.1(8) A floating-point literal usually contains an integer part, a fractional part (including a decimal point), and an exponential part.
  @Description: Check that floating-piont literal which contains only an integer part and a point throws error
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  let f32: Float32 = 233.
  return 0
}