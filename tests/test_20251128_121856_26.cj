/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a09_01

  @Level:         1
  @Assertion:       2.1.1.3(9) POSITIVE_INFINITY op POSITIVE_INFINITY = POSITIVE_INFINITY | op is ‘+’ or ’*’

  @Description:     Check that (POSITIVE_INFINITY op POSITIVE_INFINITY = POSITIVE_INFINITY) where op is one of the
                    {+, *} operations and POSITIVE_INFINITY is Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075
*/

import utils.assert.Assert

main() {
    var f64 = Float64.Inf + Float64.Inf
    var f32 = Float32.Inf + Float32.Inf
    var f16 = Float16.Inf + Float16.Inf
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)

    f64 = Float64.Inf * Float64.Inf
    f32 = Float32.Inf * Float32.Inf
    f16 = Float16.Inf * Float16.Inf
    Assert.isTrue(f64.isInf() && f64 > 0.0)
    Assert.isTrue(f32.isInf() && f32 > 0.0)
    Assert.isTrue(f16.isInf() && f16 > 0.0)
}
