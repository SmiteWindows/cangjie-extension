/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a06_01

  @Level:         1
  @Assertion:       2.1.1.3(6) num / 0 = NEGATIVE_INFINITY | num is a non-zero negative floating point number

  @Description:     Check that a non-zero negative number divided by 0 equals to negative infinity for Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006385

*/

import utils.assert.Assert

main(inp: Array<String>) {
    var f64 = -2e-300 / .0
    var f32 = -.00987654321f32 / .0
    var f16 = -.987f16 / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = -2e300 / .0
    f32 = -2e20 / .0
    f16 = -2999.0 / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = -Float64.MinDenormal / .0
    f32 = -Float32.MinDenormal / .0
    f16 = -Float16.MinDenormal / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = -Float64.MinNormal / .0
    f32 = -Float32.MinNormal / .0
    f16 = -Float16.MinNormal / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = Float64.Min / .0
    f32 = Float32.Min / .0
    f16 = Float16.Min / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = (Float64(Assert.getRuntimeZero(inp)) - 1.11) / .0
    f32 = (Float32(Assert.getRuntimeZero(inp)) - 1.11) / .0
    f16 = (Float16(Assert.getRuntimeZero(inp)) - 1.11) / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)
}
