/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a02_02

  @Level:         1

  @Assertion:    3.3.2.2(2) Static variables include static variables defined in class or struct.

  @Description:  Check using struct static variables in main.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

struct Test {
    static var sInt: Int32 = 0
    static var sTuple = (1.1, 2.2)
    static var sBool = true
    static var sRange: Range<Int32> = 1..10
}

main() {
    Test.sInt = 5
    Test.sBool = false
    let lRange: Range<Int32> = 1..10:1

    Assert.equals(5, Test.sInt)
    Assert.equals(2.2, Test.sTuple[1])

    Assert.isFalse(Test.sBool)
    Assert.isTrue(Test.sRange == lRange)
}
