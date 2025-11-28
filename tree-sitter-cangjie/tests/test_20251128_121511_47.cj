/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a02_001

  @Level:         1

  @Assertion:    3.1(2) Keywords, variables, functions, types (including class, interface, struct, enum, 
                  and type alias), packages and modules in the Cangjie programming language share 
                  the same name spaces.

  @Description:  Сheck that entities have the same namespace.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

class C {
    let x = 0.6787
}

struct S {
    let x = 4444
}

func f() {}

enum E { x }

type T = (Int64, Int64)

main() {
    var classObj = C()
    Assert.isTrue(classObj is C)
    Assert.equals(0.6787, classObj.x)

    var structObj = S()
    Assert.isTrue(structObj is S)
    Assert.equals(4444, structObj.x)

    var funcObj = f
    Assert.isTrue(funcObj is () -> Unit)

    var enumObj = E.x
    Assert.isTrue(enumObj is E)

    var aliasObj: T = (56, 753434534)
    Assert.isTrue(aliasObj is T)
}