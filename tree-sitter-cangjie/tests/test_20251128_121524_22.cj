/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a03_03

  @Level:         1

  @Assertion:    3.2.4(3) If the name C is a type, the type in the upper-scope is shadowed.

  @Description:  Check shadowing interface name

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

interface T {}

class C <: T {
    var myField: String

    func T() {
        if (true) {
            func T(): Int64 { 1 }
            Assert.equals(1, T())
        }
        if (true) {
            var T: Bool = true
            Assert.equals(true, T)
            myField = "done"
        }
    }

    C() {
        myField = "foo"
        T()
    }
}

type Alias = T

main() {
    var t = C()
    Assert.equals("done", t.myField)

    for (T in 0..1) {
        Assert.isTrue(T is Int64)
        if (true) {
            var T: String
            T = "foo"
            Assert.equals("foo", T)
        }
    }

    match (t) {
        case x: T => if (true) {
            let T = C()
            Assert.isTrue(T is Alias)
        }
        case _ => throw Exception("Must not happen")
    }

    match (t) {
        case T => Assert.isTrue(T is Alias)
    }

    func T(): Bool { true }
    Assert.isTrue(T())
}
