/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_a01_01

  @Level:         1
  @Assertion:   3.2.3(1) Based on where the names are declared or defined,
                we distinguish three types of scopes: top-level, local-level, and type-internal.
  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.Assert

let y = 4
let x = y
open class X {
    let v = y
}

main() {
    Assert.equals(4, y, reason: "Constant 'y' doesn't initialized in global scope")
    Assert.equals(4, x, 
        reason: "Constant 'y' doesn't initialized in global scope so global constant 'x' also not initialized")
    let z = y
    Assert.equals(4, z, 
        reason: "Constant 'y' doesn't initialized in global scope so local constant 'z' also not initialized")
    let x1 = X()
    Assert.equals(4, x1.v, 
        reason: 
            "Constant 'y' doesn't initialized in global scope so type-internal constant 'x1.v' also not initialized")
    return 0
}
