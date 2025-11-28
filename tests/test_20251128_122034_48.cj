/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a11_10

  @Level:         1
  @Assertion:   2.1.1.1(11) In the hexadecimal representation, a floating point number must contain at least one integer part 
                or fractional part (prefixed with 0x) and must contain an exponential part (prefixed with p or P, and base 2).
  @Description: Check that without an exponential part throws error
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  var f64: Float64 = 0x.67 // only fractional part
  return 0
}