/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_a01_09

  @Level:         1
  @Assertion:   3.2.3(1) Based on where the names are declared or defined,
                we distinguish three types of scopes: top-level, local-level, and type-internal.
  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.Assert

open class X {
    var y = 451
    var x = y
    let a = 911
    let b = a
    let c = y
    var d = a
    init() {
        Assert.equals(451, y, reason:"Variable 'y' doesn't initialized in type-internal scope")
        Assert.equals(451, x, reason:
        "Variable 'y' doesn't initialized in type-internal scope so type-internal variable 'x' also not initialized")
        Assert.equals(911, a, reason: "Constant 'a' doesn't initialized in type-internal scope")
        Assert.equals(911, b, reason:
        "Constant 'a' doesn't initialized in type-internal scope so type-internal constant 'b' also not initialized")
        Assert.equals(451, c, reason:
        "Variable 'y' doesn't initialized in type-internal scope so type-internal constant 'c' also not initialized")
        Assert.equals(911, d, reason:
        "Constant 'a' doesn't initialized in type-internal scope so type-internal variable 'd' also not initialized")
    }
}

main() {
    var x1 = X()
    return 0
}
