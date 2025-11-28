/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a14_01

  @Level:         1
  @Assertion:       2.1.1.3(14) NEGATIVE_INFINITY / num = NEGATIVE_INFINITY | num = 0 or num = 1.0

  @Description:     Check that (NEGATIVE_INFINITY / n = NEGATIVE_INFINITY) where n is 0 or 1 and NEGATIVE_INFINITY is
                    Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006385

*/

import utils.assert.Assert

main() {
    var f64 = -Float64.Inf / .0
    var f32 = -Float32.Inf / .0
    var f16 = -Float16.Inf / .0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)

    f64 = -Float64.Inf / 1.0
    f32 = -Float32.Inf / 1.0
    f16 = -Float16.Inf / 1.0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)
}
