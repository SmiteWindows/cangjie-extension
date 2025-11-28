/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a06_06

  @Level:         1
  @Assertion:    3.2.4(6) If the name f is a non-static member function in a class or interface,
                 f may be overloaded based on the overloading rule.
  @Mode:         run
  @Negative:     no

*/

package test

import utils.assert.Assert

interface I1 {
    static func f(): Int64 { 0 }
}

interface I2 {
    static func g(x: Bool): Bool { x }
}

open class Base <: I1 {
    public static func f(x: Int64): Int64 { x+1 }
}

class C <: Base & I2 {
    public static func g(x: String, y: Int64): String { x + "_${y}" }
}

main() {
    Assert.equals(0, C.f())
    Assert.equals(1, C.f(0))
    Assert.isTrue(C.g(true))
    Assert.equals("foo_123", C.g("foo", 123))
}
