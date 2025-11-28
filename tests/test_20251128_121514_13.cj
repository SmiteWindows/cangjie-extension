/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a04_01

  @Level:         1

  @Assertion:    3.2.4(4) If the name x is a variable, the variable in the upper-scope is shadowed.
                 For specific rules on masking of member variables, see Chapter of “Class and Interface”.

  @Description:  Check shadowing variable in package-level scope

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: package_other.cj

*/

package test

import other.*

import utils.assert.Assert
import utils.macros.*

var varInPackage1 = "ok"

func varInPackage2() { "ok" }

let letInPackage1 = "ok"

class letInPackage2 {
    let foo = "ok"
}

enum letInPackage3 { letInPackage4 | smthElse }

var e : letInPackage3 = letInPackage3.letInPackage4

main() {
    Assert.equals("ok", varInPackage1)
    Assert.equals("ok", varInPackage2())
    Assert.equals("ok", letInPackage1)
    Assert.equals("ok", letInPackage2().foo)
    @matchOrThrow [letInPackage3.letInPackage4] (e)
}
