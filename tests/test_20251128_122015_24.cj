/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a22_01

  @Level:         1
  @Assertion:   2.1.1.1(22) For Float64, the smallest representational positive number is 2^−1074, approximately 4.9e-324.
  @Description: Check example
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  var f64: Float64 = 4.9406564584124654e-324
  var f64_1: Float64 = Float64(2.0 ** -1074)
  Assert.equals(f64_1, f64)
  Assert.notEquals(0.0, f64)
  Assert.notEquals(0.0, f64_1)

  return 0
}