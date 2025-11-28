/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a05_01

  @Level:         1
  @Assertion:       2.1.1.3(5) num / 0 = POSITIVE_INFINITY | num is a non-zero positive floating-point number

  @Description:     Check that a non-zero positive number divided by 0 equals to positive infinity for Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006385

*/

import utils.assert.Assert

main(inp: Array<String>) {
    var f64 = 1e-300 / .0
    var f32 = .00987654321f32 / .0
    var f16 = .987f16 / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = 1e300 / .0
    f32 = 1e20 / .0
    f16 = 1999.0 / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = Float64.MinDenormal / .0
    f32 = Float32.MinDenormal / .0
    f16 = Float16.MinDenormal / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = Float64.MinNormal / .0
    f32 = Float32.MinNormal / .0
    f16 = Float16.MinNormal / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = Float64.Max / .0
    f32 = Float32.Max / .0
    f16 = Float16.Max / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = (Float64(Assert.getRuntimeZero(inp)) + 36.0) / .0
    f32 = (Float32(Assert.getRuntimeZero(inp)) + 36.0) / .0
    f16 = (Float16(Assert.getRuntimeZero(inp)) + 36.0) / .0
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)
}
