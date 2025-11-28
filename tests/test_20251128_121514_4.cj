/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a19_01

  @Level:         1
  @Assertion:   2.1.1.1(19) Floating point number in Cangjie programming language take the subnormal 
                floating point number as positive minimal number.
  @Description: Check positive minimal number
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  var f16: Float16 = 5.9604645e-8
  Assert.notEquals(0.0, f16)

  var f32: Float32 = 1.4012984643E-45
  Assert.notEquals(0.0, f32)

  var f64: Float64 = 4.9406564584124654e-324
  Assert.notEquals(0.0, f64)

  return 0
}