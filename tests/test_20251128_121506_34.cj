/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a07_01

  @Level:         1

  @Assertion:    3.2.3.2(7) As a result, mutual recursion is not supported, but can call itself recursively.

  @Description:  Check that the function can be called recursively.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      Local function scope starts after the function defined and ends with the closing of the block.

*/

import utils.assert.Assert

var counter = 0

main() {
// test case #1
    func foo1() : Int32 {
        counter++
        if (counter < 10) {
            foo1()
        }
        return 0
    }

    counter = 0
    foo1()
    Assert.equals(10, counter)

// test case #2
    func foo2() : Unit {
        func f(): Unit {
            counter++
            if (counter < 10) {
                f()
            }
        }
        f()
    }

    counter = 0
    foo2()
    Assert.equals(10, counter)
}
