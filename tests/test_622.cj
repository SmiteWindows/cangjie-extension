/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a09_01

  @Level:         1
  @Assertion:   2.1.1.1(9) There are two forms of representation: decimal or hexadecimal. In the decimal representation, a floating-point number must contain an integer part or a fractional part.
  @Description: Check that values of two forms of representation are same
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  let f16_1: Float16 = 0x1p2
  Assert.equals(4.0, f16_1)
  var f16_2: Float16 = 0x1.2p0
  Assert.equals(1.125, f16_2)
  var f16_3: Float16 = 0xFFp-1
  Assert.equals(127.5, f16_3)
  
  let f32_1: Float32 = 0x1p32
  Assert.equals(4_294_967_296.0, f32_1)
  var f32_2: Float32 = 0x12a.1p0
  Assert.equals(298.0625, f32_2)
  var f32_3: Float32 = 0xFFffFFffp-1
  Assert.equals(2147483647.5, f32_3)

  let f64_1: Float64 = 0x1p32
  Assert.equals(4_294_967_296.0, f64_1)
  var f64_2: Float64 = 0x12a.1p0
  Assert.equals(298.0625, f64_2)
  var f64_3: Float64 = 0xFFffFFffp-1
  Assert.equals(2147483647.5, f64_3)
  return 0
}