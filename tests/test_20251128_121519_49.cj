/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         03_04_01_01_a01_02
  @Assertion:    3.4.1.1(1) Default access modifier, without any keyword modifiers.
                 Members declared with the default access modifier are visible to
                 members within the same package.

  @Description:  Checks that various types with default access modifier are
                 visible to members of default package.

  @Mode:         run
  @Negative:     no
  @Structure:    complex-main
  @Dependencies: aux_test_a01_02.cj
  @Comment:

*/

import utils.assert.Assert

main() {
    var numE = CONST_FLOAT
    let obj:Option<Test> = Option<Test>.None;

    Assert.equals(-2147483648, testInt, reason:"Int value must match")
    Assert.equals(CONST_FLOAT, numE, reason:"Float64 value must match")
    Assert.isTrue(trigger, reason: "Boolean value should match")
    Assert.isNone(obj, reason: "Instance wasn't created")
    Assert.equals("ABC String for testing", testFunc(), reason:"String value must match")
}
