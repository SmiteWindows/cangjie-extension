/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a11_01

  @Level:         1
  @Assertion:       2.1.1.3(11) NEGATIVE_INFINITY + NEGATIVE_INFINITY = NEGATIVE_INFINITY

  @Description:     Check that (NEGATIVE_INFINITY + NEGATIVE_INFINITY = NEGATIVE_INFINITY) where NEGATIVE_INFINITY is
                    Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075

*/

import utils.assert.Assert

main() {
    let f64 = -Float64.Inf + -Float64.Inf
    let f32 = -Float32.Inf + -Float32.Inf
    let f16 = -Float16.Inf + -Float16.Inf
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)
}
