/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a02_02

  @Level:         1

  @Assertion:    3.2.4(2) Note that shadowing ends when the lower-scope ends.

  @Description:  Check different kinds of scopes.
                 Check that top-level scope is used when type-internal scope ends. Struct case.

  @Mode:         run

  @Negative:     no

*/

package idpackage

import utils.assert.Assert
import utils.macros.*

var idVar = "global_var"

func idFunc(): String { "global_func" }

enum idEnum { idCons1 | idCons2 }

struct idStruct {
    let structField = 123
}

class idClass {
    let classField = "foo"
}

interface idInterface { }

type idAlias = String

struct Type {
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

var checkGlobalVar = idVar
var checkGlobalFunc = idFunc()

struct Foo <: idInterface {
    let e1 = idCons1
    var e2: idEnum
    let s1: idStruct = idStruct()
    var c1: idClass

    Foo() {
        e2 = idCons2
        c1 = idClass()
    }
}

main() {
    let s = Type()
    s.test()

    Assert.equals("global_var", checkGlobalVar)
    Assert.equals("global_func", checkGlobalFunc)

    var foo = Foo()

    @matchOrThrow[idCons1] (foo.e1)
    @matchOrThrow[idCons2] (foo.e2)

    Assert.equals(123, foo.s1.structField)
    Assert.equals("foo", foo.c1.classField)

    var str: idAlias
    str = "aaa"
    Assert.isTrue(str is String)
}
