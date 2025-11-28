/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a04_03

  @Level:         1

  @Assertion:       2.1.11.2(4) enum constructors are always introduced automatically 
  under the current scope and can be used by omitting the type prefix.

  @Description:     Checks that enum constructor declared in package can be used in other package scope w/o prefix

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a04_01.cj aux_test_a04_02.cj

  @Comment:

*/
package p

import p1.E
import p1
import utils.assert.Assert


main() {
    var e = D
    Assert.equals("p1.E", e.desc())
    Assert.isTrue(e is E)
    let e2 = G(r'a')
    Assert.equals("p1.E", e2.desc())
    Assert.isTrue(e2 is E)

    var pe = p1.E.D
    pe.check()
    pe = p1.E.G(r'x')
    pe.check()
}
