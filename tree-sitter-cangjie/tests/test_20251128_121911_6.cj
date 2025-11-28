/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a06_02

  @Level:         1
  @Assertion:   2.1.1.1(6) Floating-point types in the Cangjie programming language are represented using the IEEE 754
                formats.
  @Description: Check that floating-point literals equal to each other for infinities
  @Mode:        run
  @Negative:    no
  @Structure:   single
  @Issue:       0006075
*/

import utils.assert.Assert

main() {
  let f16_Inf: Float16 = 1.0/0.0
  let f16_nInf: Float16 = -1.0/0.0
  Assert.equals(Float16.Inf, f16_Inf)
  Assert.equals(-Float16.Inf, f16_nInf)

  let f32_Inf: Float32 = 1.0/0.0
  let f32_nInf: Float32 = -1.0/0.0
  Assert.equals(Float32.Inf, f32_Inf)
  Assert.equals(-Float32.Inf, f32_nInf)

  let f64_Inf: Float64 = 1.0/0.0
  let f64_nInf: Float64 = -1.0/0.0
  Assert.equals(Float64.Inf, f64_Inf)
  Assert.equals(-Float64.Inf, f64_nInf)
  return 0
}