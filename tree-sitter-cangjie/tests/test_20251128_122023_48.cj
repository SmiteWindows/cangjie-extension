/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a09_06

  @Level:         1

  @Assertion:    1.2(9) In the call expression, a newline character cannot be used as a separator
                        between ( and the token before it.

  @Description:  Newline character added as a separator between ( and the token before it
                 for call of function w/ the return type as Unit.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @CompileWarning: Ignore

  @Comment:       This test is positive because of (add, 10, 20) below is considered as valid expression.
                 If the assertion mentioned above will be violated then this test has to be failed.  

*/

import utils.assert.Assert

main() {
    func add(a: Int32, b: Int32): Int32 {
        a + b
    }

    func f(add: (Int32, Int32) -> Int32, a: Int32, b: Int32): Unit {
        let r : String = "In the call expression, a newline character cannot be used as a separator " +
                         "between ( and the token before it."
        Assert.fail(reason: r)
    }

    var s = f
    (add, 10, 20)

    return 0
}
