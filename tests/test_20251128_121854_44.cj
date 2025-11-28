/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a03_03

  @Level:         1
  @Assertion:       2.1.10.4(3) The modifier for the primary constructor is optional and can be either public or
                    private, leaving it out is Default.

  @Description:     Check that "public" can be the primary constructor modifier. Check the behavior matches the public
                    visibility.

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a03_03.cj
  @CompileWarning:  no

*/

import p3.*

import utils.assert.Assert

main() {
    // A public primary constructor is visible outside its package.
    Assert.equals(1, AuxTestA0303(1).v)
    Assert.equals(1, test().v)
}
