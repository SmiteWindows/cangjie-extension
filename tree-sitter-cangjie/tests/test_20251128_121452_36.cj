/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a05_01

  @Level:         1

  @Assertion:       3.2.2(5) 2. Names defined at the top-level of the same package have higher scope level 
                    than the names in rule 1.

  @Description:     The test imports a func f and a class A from another package and also defines a func f and the
                    class A with the same fields at the top-level of the current package. Check that calling `f` and
                    using instances of class A in different scopes calls the top-level function and class, and not the
                    imported function and class.

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a05_01.cj
  @CompileWarning:  no

  @Comment:         Rule 1: Names from other packages introduced by importclause have the lowest scope level.

*/

import p

import utils.assert.Assert

func f() { 0.431 }

func g(foo: () -> Unit) {
    Assert.approxEquals(0.431, f())
    Assert.approxEquals(0.1, p.f())

    Assert.equals(90, A.a())
    A.b()
    Assert.equals(13, A.c())

    Assert.equals(0, p.AuxTestA0501.a)
    Assert.equals(-1, p.AuxTestA0501.b)
    foo()
}

extend A {
    static func c() {
        Assert.approxEquals(0.431, f())
        Assert.approxEquals(0.1, p.f())

        Assert.equals(90, A.a())

        Assert.equals(0, p.AuxTestA0501.a)
        Assert.equals(-1, p.AuxTestA0501.b)

        13
    }
}

class A {
    public static let a = { => 90 }
    public static var b = { =>
        Assert.approxEquals(0.431, f())
        Assert.approxEquals(0.1, p.f())

        Assert.equals(90, A.a())
        Assert.equals(13, A.c())

        Assert.equals(0, p.AuxTestA0501.a)
        Assert.equals(-1, p.AuxTestA0501.b)
    }
}

main() {
    Assert.approxEquals(0.431, f())
    Assert.approxEquals(0.1, p.f())

    Assert.equals(90, A.a())
    A.b()
    Assert.equals(13, A.c())

    Assert.equals(0, p.AuxTestA0501.a)
    Assert.equals(-1, p.AuxTestA0501.b)
    g(A.b)
}
