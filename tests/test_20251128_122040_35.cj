/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a03_04

  @Level:         1

  @Assertion:    3.2.4(3) If the name C is a type, the type in the upper-scope is shadowed.

  @Description:  Check shadowing enum name

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

enum T { Cons1 | Cons2 }

class C {
    var myField: String

    func T() {
        if (true) {
            func T(): Int64 { 1 }
            Assert.equals(1, T())
            func Cons1(): Int64 { 1 }
            Assert.equals(1, Cons1())
        }
        if (true) {
            var T: Bool = true
            Assert.equals(true, T)
            var Cons1: Bool = true
            Assert.equals(true, Cons1)
            myField = "done"
        }
    }

    C() {
        myField = "foo"
        T()
    }
}

type AliasC = C
type AliasT = T

main() {
    var t = C()
    Assert.equals("done", t.myField)

    for (T in 0..1) {
        Assert.isTrue(T is Int64)
        for (Cons1 in 0..1) {
            Assert.isTrue(Cons1 is Int64)
            var T: String
            T = "foo"
            Assert.equals("foo", T)
        }
    }

    match (Cons1) {
        case x: T => if (true) {
            let T = C()
            Assert.isTrue(T is AliasC)
        }
        case _ => throw Exception("Must not happen")
    }

    match (t) {
        case T => Assert.isTrue(T is AliasC)
    }

    match (Cons1) {
        case T => Assert.isTrue(T is AliasT)
    }

    func T(): Bool { true }
    Assert.isTrue(T())

    func Cons1(): Bool { true }
    Assert.isTrue(Cons1())
}
