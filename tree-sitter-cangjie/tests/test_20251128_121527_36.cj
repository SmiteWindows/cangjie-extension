/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a03_01

  @Level:         1
  @Assertion:       2.1.10.4(3) The modifier for the primary constructor is optional and can be either public or
                    private, leaving it out is Default.

  @Description:     Check that the modifier for the primary constructor is optional. Check the behavior matches the
                    default visibility.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

struct S {
    let v: Int64
    S(v: Int64) { this.v = v }
}

main() {
    Assert.equals(1, S(1).v)
}
