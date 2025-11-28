/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a05_04

  @Level:         1

  @Assertion:    3.2.3.2(5) If the name of the local variable is the same as an entities defined in an upper-level 
                 scope, the upper-level entity is shadowed whenever the local variable is accessible.

  @Description:  Checks that the upper-level entity is not shadowed when the local variable with same name 
                 is accessible for the for loop.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    let tmp : Int32 = -1
    let intArray: Array<Int32> = [0, 1, 2, 3, 4]
    for (item in intArray) {
        let tmp : Int32 = item
        Assert.equals(item, tmp)
    }
}
