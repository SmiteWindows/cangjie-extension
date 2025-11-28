/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a18_01

  @Level:         1
  @Assertion:       2.1.1.3(18) 0 / Inf = sign(Inf)0.0 | Inf is POSITIVE_INFINITY or NEGATIVE_INFINITY, the sign of
                    result is determined by the sign of Inf (i.e., sign(NEGATIVE_INFINITY) = ‘-’)

  @Description:     Check that 0 divided by +inf gives +0, and divided by -inf gives -0 for Float64/32/16.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006320,0006385

*/

import utils.assert.Assert

main() {
    Assert.isTrue(.0 / Float64.Inf == .0)
    Assert.isTrue(.0 / Float32.Inf == .0)
    Assert.isTrue(.0 / Float16.Inf == .0)

    Assert.isTrue(.0 / -Float64.Inf == -0.0)
    Assert.isTrue(.0 / -Float32.Inf == -0.0)
    Assert.isTrue(.0 / -Float16.Inf == -0.0)
}
