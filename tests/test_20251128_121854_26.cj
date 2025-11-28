/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a07_03

  @Level:         1
  @Assertion:    3.2.4(7) If  f is not overloaded, override may occur.
                 Check that redef modifier is optional.
  @Mode:         run
  @Negative:     no

*/

package test

import utils.assert.Assert

open class Base {
    static func f(): Int64 { 0 }
    static func g(x!: Bool = true): Bool { x }
}

class C <: Base {
    static func f(): Int64 { 1 }
    redef static func g(x!: Bool = false): Bool { !x }
}

main() {
    Assert.equals(1, C.f())
    Assert.isTrue(C.g())
    Assert.isFalse(C.g(x: true))
}
