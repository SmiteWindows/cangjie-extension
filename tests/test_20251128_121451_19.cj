/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a01_03

  @Level:         1

  @Assertion:    3.2.4(1) When two scopes overlap and the same name appears in both scopes, the name in the
                 lower-scope shadows the name in the upper-scope. As a result, the entity referred to by the
                 name in the lower-scope cannot be accessed directly through the name.

  @Description:  Check different kinds of scopes.
                 Check that name in type-internal scope shadows name in top-level scope. Class case.

  @Mode:         run

  @Negative:     no

*/

package idpackage

import utils.assert.Assert

var idVar = "unused"

func idFunc(): String { "unused" }

enum idEnum { idCons1 | idCons2 }

struct idStruct { }

class idClass { }

interface idInterface { }

type idAlias = String

class Type {
    let idPackage = "ok"

    static let idFunc: Int32 = 100

    var idVar: Bool

    private var idCons1: Int32 = 200

    let idStruct: () -> Int32 = { => idFunc }

    Type(var idEnum!: String = "ok", var idAlias!: String = "ok") {
        Assert.equals("ok", idEnum)
        Assert.equals("ok", idAlias)

        Assert.equals(100, idFunc)

        idVar = true
        Assert.isTrue(idVar)

        Assert.equals(200, idCons1)
    }

    func test() {
        Assert.equals("ok", idPackage)
        Assert.equals(100, idStruct())
        Assert.equals(300, idCons2())
        Assert.equals("ok", idClass())
        Assert.equals("ok", idInterface())
    }

    private func idCons2(): Int32 { idCons1 + idFunc }

    public func idClass(): String { "ok" }

    public func idInterface(): String { "ok" }
}

main() {
    let s = Type()
    s.test()
}
