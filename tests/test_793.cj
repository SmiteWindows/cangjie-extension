/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a11_01

  @Level:         1
  @Assertion:   2.1.1.1(11) In the hexadecimal representation, a floating point number must contain at least one integer part 
                or fractional part (prefixed with 0x) and must contain an exponential part (prefixed with p or P, and base 2).
  @Description: Check that various combinations of parts parsed correctly
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  let f16_1: Float16 = 0x1p2 // integer and exponential parts
  Assert.equals(4.0, f16_1)
  var f16_2: Float16 = 0X1.2p0 // integer and fractional parts and zero exponential
  Assert.equals(1.125, f16_2)
  var f16_3: Float16 = 0x.2p3 // fractional and exponential parts
  Assert.equals(1.0, f16_3)
  var f16_4: Float16 = 0x.23p0 // fractional part and zero exponential
  Assert.equals(0.13671875, f16_4)
  var f16_5: Float16 = 0X321.2p-2 // integer and fractional and exponential parts
  Assert.equals(200.28125, f16_5)
  
  return 0
}