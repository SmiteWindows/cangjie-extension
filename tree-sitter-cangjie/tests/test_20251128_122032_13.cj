/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a10_04

  @Level:         1
  @Assertion:   2.1.1.1(10) An exponential part (prefixed with e or E, and base 10) is required when there is no decimal part.
  @Description: Check that floating-point literal without fractional part and exponential part throws error
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  let f: Float64 = 654f32
  return 0
}