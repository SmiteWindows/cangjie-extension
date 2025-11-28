/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a21_01

  @Level:         1

  @Assertion:    3.2.3.2(21) Each match case has an independent scope.

  @Description:  Checks that the scope is different for cases of match expression.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

open class Test {
    public var xx : Int64 = -1
    public var yy : Int64 = -1
}

main() {
// test case #1
    for (num in [0, 1, 2]) {
        let item : Int64 = num
        let rez : Int64 = match(num) {
            case 1 => let t = Test(); t.xx = 1; t.xx
            case 2 => let t = Test(); t.xx = 2; t.xx
            case _ => let t = Test(); t.xx = 0; t.xx 
        }

        Assert.equals(item, rez)
    }

// test case #2
    for (num in [10, 20, 30]) {
        let item : Int64 = num
        let rez : Int64 = match {
            case num == 20 => let t = Test(); t.yy = 20; t.yy
            case num == 30 => let t = Test(); t.yy = 30; t.yy
            case _         => let t = Test(); t.yy = 10; t.yy 
        }

        Assert.equals(item, rez)
    }
}
