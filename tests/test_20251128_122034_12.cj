/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a21_01

  @Level:         1
  @Assertion:   2.1.1.1(21) The largest representational positive number is (2 − 2^−23) × 2^127, approximately 3.40282e38.
  @Description: Check example
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  var f32: Float32 = 3.4028234664e38
  var f32_1: Float32 = Float32((2.0 - (2.0 ** -23)) * (2.0 ** 127))
  Assert.equals(f32_1, f32)
  Assert.equals(Float32.Max, f32)
  Assert.equals(Float32.Max, f32_1)

  return 0
}