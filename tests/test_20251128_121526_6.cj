/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a22_04

  @Level:         1

  @Assertion:    3.2.3.2(22) For all three types of loops, the loop condition has the same scope level 
                 as the loop block, i.e. the names introduced therein must not shadow each other.

  @Description:  Checks that the name introduced in the do-while expression shadows the loop condition variable.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    var a = 1
    do {
        Assert.equals(1, a)
        a = -1
        var a = 0
        Assert.equals(0, a)
    } while (a > 0)
}
