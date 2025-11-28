/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a02_02

  @Level:         1
  @Assertion:       3.2.2(2) Scopes are nested.

  @Description:     An example of nested scopes with a bug.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006070

*/

import utils.assert.Assert

main() {
    var a = 0
    { =>
        func t<T>() { let unused: T }
        t<Nothing>()
        Assert.equals(0, a)
    }()
}
