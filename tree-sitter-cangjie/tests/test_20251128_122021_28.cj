/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a12_04

  @Level:         1
  @Assertion:   2.1.1.1(12) In addition, the following are additional special floating-point literals:
                positive infinity (POSITIVE_INFINITY), negative infinity (NEGATIVE_INFINITY), 
                Not a Number (NaN), positive 0 (+0.0) and negative 0 (-0.0).
  @Description: Check positive infinity (POSITIVE_INFINITY)
  @Mode:        run
  @Negative:    no
  @Structure:   single
  @Issue:       6075
*/

import utils.assert.Assert

main() {
  var f16: Float16 = Float16.Inf
  Assert.equals(Float16(1.0/0.0), f16)

  var f32: Float32 = Float32.Inf
  Assert.equals(Float32(1.0/0.0), f32)

  var f64: Float64 = Float64.Inf
  Assert.equals(Float64(1.0/0.0), f64)

  Assert.equals(Float32(Float16.Inf), Float32.Inf)
  Assert.equals(Float64(Float16.Inf), Float64.Inf)
  Assert.equals(Float64.Inf, Float64(Float32.Inf))
  return 0
}