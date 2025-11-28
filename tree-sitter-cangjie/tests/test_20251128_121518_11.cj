/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a01_01

  @Level:         1

  @Assertion:    3.3.2.2(1) Variables defined at the top-level are called global variables.

  @Description:  Using global variable in main.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

var gInt: Int32 = 0
var gTuple = (1.1, 2.2)
var gBool = true
var gRange: Range<Int32> = 1..10

main() {
    gInt = 5
    gBool = false
    let lRange: Range<Int32> = 1..10:1

    Assert.equals(5, gInt)
    Assert.equals(2.2, gTuple[1])

    Assert.isFalse(gBool)
    Assert.isTrue(gRange == lRange)
}
