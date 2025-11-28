/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a01_02

  @Level:         1

  @Assertion:    3.3.2.2(1) Variables defined at the top-level are called global variables.

  @Description:  Check that global variable is visible in another source file.

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_test_a01_02.cj

  @Issue:        0006065

*/

import utils.assert.Assert

var gInt: Int32 = 0
var gTuple = (1.1, 2.2)
var gBool = true
var gRange: Range<Int32> = 1..10

main() {
    gInt = 5
    gBool = false
    let lRange: Range<Int32> = 1..12:1
    foo()
    Assert.equals(gInt, 7)
    Assert.equals(gTuple[1], 3.3)
    Assert.isTrue(gBool)
    Assert.isTrue(gRange == lRange)
}
