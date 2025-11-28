/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a02_04

  @Level:         1

  @Assertion:    3.2.4(2) Note that shadowing ends when the lower-scope ends.

  @Description:  Check different kinds of scopes.
                 Check that top-level scope is used when type-internal scope ends. Interface case.

  @Mode:         run

  @Negative:     no

*/

package idpackage

import utils.assert.Assert

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

interface Type {
    func idPackage(): String
    func idVar(): Bool
    func idFunc(): Int32
    func idCons1(idCons2: String): String
    func idEnum(idAlias: Bool): Bool
    func idStruct(): String
    func idClass(): String
    func idInterface(): String
    func idAlias(): Bool
}

var checkGlobalVar = idVar
var checkGlobalFunc = idFunc()
var checkGlobalEnum = idCons1
var checkGlobalStruct = idStruct()
var checkGlobalClass = idClass()
var checkGlobalAlias: idAlias = "string"

class Test <: idInterface {
    Test() {
        Assert.equals("global_var", checkGlobalVar)
        Assert.equals("global_func", checkGlobalFunc)
        Assert.isTrue(checkGlobalEnum is idEnum)
        Assert.equals("foo", checkGlobalClass.classField)
        Assert.equals("string", checkGlobalAlias)
    }
}

main() {
    let t = Test()
}
