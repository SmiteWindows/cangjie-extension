/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a10_01

  @Level:         1
  @Assertion:       2.1.1.3(10) POSITIVE_INFINITY op POSITIVE_INFINITY = NaN | op is ‘-’ or ‘/’

  @Description:     Check that (POSITIVE_INFINITY op POSITIVE_INFINITY = NaN) where op is one of the {-, /} operations
                    and POSITIVE_INFINITY is Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075

*/

import utils.assert.Assert

main() {
    Assert.isTrue((Float64.Inf - Float64.Inf).isNaN())
    Assert.isTrue((Float32.Inf - Float32.Inf).isNaN())
    Assert.isTrue((Float16.Inf - Float16.Inf).isNaN())

    Assert.isTrue((Float64.Inf / Float64.Inf).isNaN())
    Assert.isTrue((Float32.Inf / Float32.Inf).isNaN())
    Assert.isTrue((Float16.Inf / Float16.Inf).isNaN())
}
