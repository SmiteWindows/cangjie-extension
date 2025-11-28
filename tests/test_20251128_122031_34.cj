/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a01_05

  @Level:         1

  @Assertion:    3.2.4(1) When two scopes overlap and the same name appears in both scopes, the name in the
                 lower-scope shadows the name in the upper-scope. As a result, the entity referred to by the
                 name in the lower-scope cannot be accessed directly through the name.

  @Description:  Check different kinds of scopes.
                 Check that name in type-internal scope shadows name in top-level scope. Interface case.

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

interface Type {
    func idPackage(): String
    func idVar(): Bool
    func idFunc(): Int32
    func idCons1(idCons2: String): String
    func idEnum(idAlias: Bool): Bool
    func idStruct(): String
    func idClass(): String
    func idInterface(): String
    func idAlias(): String
}

class Test <: Type {
    public func idPackage(): String { "ok" }
    public func idVar(): Bool { false }
    public func idFunc(): Int32 { 123 }
    public func idCons1(idCons2: String): String { idCons2 }
    public func idEnum(idAlias: Bool): Bool { idAlias }
    public func idStruct(): String { "ok" }
    public func idClass(): String { "ok" }
    public func idInterface(): String { "ok" }
    public func idAlias(): String { "ok" }
}

main() {
    let t = Test()
    Assert.equals("ok", t.idPackage())
    Assert.equals(false, t.idVar())
    Assert.equals(123, t.idFunc())
    Assert.equals("456", t.idCons1("456"))
    Assert.equals(true, t.idEnum(true))
    Assert.equals("ok", t.idStruct())
    Assert.equals("ok", t.idClass())
    Assert.equals("ok", t.idInterface())
    Assert.equals("ok", t.idAlias())
}
