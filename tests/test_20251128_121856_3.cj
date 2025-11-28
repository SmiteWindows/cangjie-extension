/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a02_01

  @Assertion:    3.2.4(2) Note that shadowing ends when the lower-scope ends.

  @Description:  Check different kinds of scopes.
                 Check that top-level scope is used when local-level scope ends.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/

import utils.assert.Assert
import utils.utils.macros.*

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

func test() {
    if (true) {
        func idVar(): String { "ok" }
        Assert.equals("ok", idVar())
    }

    Assert.equals("global_var", idVar)

    if (true) {
        var idFunc = "ok"
        Assert.equals("ok", idFunc)
    }

    Assert.equals("global_func", idFunc())

    if (true) {
        let idCons1: Int32 = 100
        let idCons2: () -> Int32 = { => 200 }
        let idEnum: Int32 = idCons1 + idCons2()
        Assert.equals(300, idEnum)
    }

    let e1: idEnum = idCons1;
    var e2: idEnum = idCons2;

    @matchOrThrow[idCons1] (e1)
    @matchOrThrow[idCons2] (e2)

    if (true) {
        var idStruct = "ok"
        Assert.isTrue(idStruct is String)

        let idClass = "ok"
        Assert.isTrue(idClass is String)
    }

    var s1: idStruct = idStruct()
    Assert.equals(123, s1.structField)

    var c1: idClass = idClass()
    Assert.equals("foo", c1.classField)

    func idInterface(): String { "ok" }
    Assert.equals("ok", idInterface())

    if (true) {
        let idAlias = false
        Assert.isTrue(idAlias is Bool)
    }

    let a1: idAlias = "test"
    Assert.isTrue(a1 is String)
}

class UseIdInterface <: idInterface { }

main() {
    test()
}
