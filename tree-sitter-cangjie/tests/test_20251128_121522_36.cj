/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a01_03

  @Level:         1
  @Assertion:       2.1.10.4(1) The structModifier in the struct definition is an optional access modifier, which can
                    only be public or not provided (the default is accessible only within the package).

  @Description:     Check that "public" can be an access modifier in the struct definition and that its behavior is as
                    described in section "3.4.1.3 Public access modifiers".

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a01_03.cj
  @CompileWarning:  no

*/

import p3.AuxTestA0103

main() {
    AuxTestA0103()
    0
}
