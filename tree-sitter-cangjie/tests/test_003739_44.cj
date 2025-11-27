/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a02_03

  @Level:         1

  @Assertion:    3.3.2.2(2) Static variables include static variables defined in class or struct.

  @Description:  Check that static variables are visible in another source file.

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_test_a02_03.cj

  @Issue:        0006065

*/

import utils.assert.Assert

class TestClass {
    static var sInt: Int32 = 0
    static var sTuple = (1.1, 2.2)
    static var sBool = true
    static var sRange: Range<Int32> = 1..10
}

struct TestStruct {
    static var sInt: Int32 = 0
    static var sTuple = (1.1, 2.2)
    static var sBool = true
    static var sRange: Range<Int32> = 1..10
}

main() {
    TestClass.sInt = 5
    TestClass.sBool = false
    TestStruct.sInt = 5
    TestStruct.sBool = false
    let lRange: Range<Int32> = 1..12:1
    foo()
    Assert.equals(TestClass.sInt, 7)
    Assert.equals(TestClass.sTuple[1], 3.3)
    Assert.isTrue(TestClass.sBool)
    Assert.isTrue(TestClass.sRange == lRange)

    Assert.equals(TestStruct.sInt, 7)
    Assert.equals(TestStruct.sTuple[1], 3.3)
    Assert.isTrue(TestStruct.sBool)
    Assert.isTrue(TestStruct.sRange == lRange)
}
