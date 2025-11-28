/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a18_01

  @Level:         1
  @Assertion:   2.1.1.1(18) The following are examples of floating-point literals.
                  3.14 // decimal Float64 3.14.
                  2.4e-1 // decimal Float64 0.24.
                  2e3 // decimal Float64 2000.0.
                  .8 // decimal Float64 0.8.
                  .123e2 // decimal Float64 12.3.
                  0x1.1p0 // hexadecimal Float64 1.0625 (decimal value).
                  0x1p2 // hexadecimal Float64 4 (decimal value).
                  0x.2p4 // hexadecimal Float64 2 (decimal value).
  @Description: Check examples
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  var f1 = 3.14
  Assert.equals(3.14_f64, f1)
  var f2 = 2.4e-1
  Assert.equals(0.24_f64, f2)
  var f3 = 2e3
  Assert.equals(2000.0_f64, f3)
  var f4 = .8
  Assert.equals(0.8_f64, f4)
  var f5 = .123e2
  Assert.equals(12.3_f64, f5)
  var f6 = 0x1.1p0
  Assert.equals(1.0625_f64, f6)
  var f7 = 0x1p2
  Assert.equals(4.0_f64, f7)
  var f8 = 0x.2p4
  Assert.equals(2.0_f64, f8)
  return 0
}