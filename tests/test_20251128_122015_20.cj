/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a16_02

  @Level:         1
  @Assertion:   2.1.1.1(16) NaN represents a value that is neither a real value nor infinity.
  @Description: Check comparsion ooperations with NaNs
  @Mode:        run
  @Negative:    no
  @Structure:   single
  @Issue:       0006075
*/

import utils.assert.Assert

main() {
  var f16: Float16 = 0.0 / 0.0
  var f16_1: Float16 = -Float16.Inf / Float16.Inf
  var f16_2: Float16 = Float16.Inf * 0.0 / 0.0

  Assert.isFalse(Float16.NaN == Float16.NaN)
  Assert.isFalse(Float16.NaN == f16)
  Assert.isTrue(Float16.NaN != f16)
  Assert.isFalse(Float16.NaN > f16_1)
  Assert.isFalse(Float16.NaN < f16_1)
  Assert.isFalse(Float16.NaN >= f16_2)
  Assert.isFalse(Float16.NaN <= f16_2)

  var f32: Float32 = 0.0 / 0.0
  var f32_1: Float32 = -Float32.Inf / Float32.Inf
  var f32_2: Float32 = Float32.Inf * 0.0 / 0.0

  Assert.isFalse(Float32.NaN == Float32.NaN)
  Assert.isFalse(Float32.NaN == f32)
  Assert.isTrue(Float32.NaN != f32)
  Assert.isFalse(Float32.NaN > f32_1)
  Assert.isFalse(Float32.NaN < f32_1)
  Assert.isFalse(Float32.NaN >= f32_2)
  Assert.isFalse(Float32.NaN <= f32_2)

  var f64: Float64 = 0.0 / 0.0
  var f64_1: Float64 = -Float64.Inf / Float64.Inf
  var f64_2: Float64 = Float64.Inf * 0.0 / 0.0

  Assert.isFalse(Float64.NaN == Float64.NaN)
  Assert.isFalse(Float64.NaN == f64)
  Assert.isTrue(Float64.NaN != f64)
  Assert.isFalse(Float64.NaN > f64_1)
  Assert.isFalse(Float64.NaN < f64_1)
  Assert.isFalse(Float64.NaN >= f64_2)
  Assert.isFalse(Float64.NaN <= f64_2)

  return 0
}