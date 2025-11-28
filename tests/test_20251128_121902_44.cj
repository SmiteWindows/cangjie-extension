/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a03_03

  @Level:         1
  @Assertion:       3.2.2(3) Names in its nested scope can be accessed directly by using the name without 
                    any qualifier, if they are not shadowed or overridden.

  @Description:     Check that we cannot access an entity by the name without any qualifier, if it is shadowed or
                    overridden.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006086

*/

import utils.assert.Assert

func f() { 23 }

open class Base {
    let g = "dj"

    func f() { 199 }

    func checkShadowingGlobal() {
        Assert.equals(199, f())
    }
}

class Shadow <: Base {
    let Base = { => 15 }

    func checkShadowingBase() {
        Assert.equals(199, super.f())
        Assert.equals(15, Base())

        Assert.equals("dj", g)
        Assert.equals("dj", super.g)
    }
}

class Override <: Base {
    public func f(_: Int64) { -13 }

    let Base = { => 17 }

    func checkOverriding() {
        Assert.equals(-13, f(super.f()))
        Assert.equals(199, super.f())
        Assert.equals(17, Base())
    }
}

main() {
    func f() { 98 }
    Assert.equals(98, f())

    Base().checkShadowingGlobal()
    Shadow().checkShadowingBase()
    Override().checkOverriding()
}
