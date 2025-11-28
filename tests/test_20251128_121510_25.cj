/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a08_10

  @Level:         1
  @Assertion:       2.1.10.4(8) Members without visibility modifiers are visible both inside the struct definition and
                    inside the package.

  @Description:     Check that a static member function without an access modifier is invisible outside the package.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       complex-main
  @Dependencies:    aux_test_a08_10.cj
  @CompileWarning:  no

*/

import p10.AuxTestA0810

main() {
    AuxTestA0810.f()
    0
}
