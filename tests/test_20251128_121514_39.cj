/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a15_01

  @Level:         1
  @Assertion:       2.1.1.3(15) POSITIVE_INFINITY / -1.0 = NEGATIVE_INFINITY

  @Description:     Check that (POSITIVE_INFINITY / -1 = NEGATIVE_INFINITY) where POSITIVE_INFINITY is Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006385

*/

import utils.assert.Assert

main() {
    let f64 = Float64.Inf / -1.0
    let f32 = Float32.Inf / -1.0
    let f16 = Float16.Inf / -1.0
    Assert.isTrue(f64.isInf() && f64 < 0.0)
    Assert.isTrue(f32.isInf() && f32 < 0.0)
    Assert.isTrue(f16.isInf() && f16 < 0.0)
}
