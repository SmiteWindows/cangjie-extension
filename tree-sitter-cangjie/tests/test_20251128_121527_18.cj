/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a04_02

  @Level:         1

  @Assertion:    3.2.4(4) If the name x is a variable, the variable in the upper-scope is shadowed.
                 For specific rules on masking of member variables, see Chapter of “Class and Interface”.

  @Description:  Check shadowing variable in top-level scope

  @Mode:         run

  @Negative:     no

*/

package test

import utils.assert.Assert

var varInPackage1 = "not-seen"
var varInPackage2 = "not-seen"

let letInPackage1 = "not-seen"
let letInPackage2 = "not-seen"
let letInPackage3 = "not-seen"
let letInPackage4 = "not-seen"

class C {
    var varInPackage1: String
    C() {
        varInPackage1 = "ok"
        var varInPackage2 = "ok"
        Assert.equals("ok", varInPackage2)
    }
}

func run(letInPackage3!: String = "ok") {
    Assert.equals("ok", letInPackage3)
}

main() {
    Assert.equals("ok", C().varInPackage1)
    var letInPackage1 = 123
    Assert.equals(123, letInPackage1)
    let letInPackage2 = 123
    Assert.equals(123, letInPackage2)
    run()
    for (letInPackage4 in 0..1) {
        Assert.isTrue(letInPackage4 is Int64)
    }
}
