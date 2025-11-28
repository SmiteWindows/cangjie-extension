/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a02_01

  @Level:         1

  @Assertion:    3.2.3.2(2) The variables defined within a block has higher level of scope 
                 than the ones defined outside.

  @Description:  Checks that variable defined within some blocks is invisible for the main function.

  @Mode:        run

  @Negative:    no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    var v1 : Int32 = 10
    let v2 : Int64 = 11
    let v3 : String = "bla-bla"

// test case #1
    if (true) { 
        let v1 : Int32 = 0
        let v2 : Int64 = 1
        let v3 : String = "block #1"
    }

    Assert.equals(10, v1)
    Assert.equals(11, v2)
    Assert.equals("bla-bla", v3)

// test case #2
    func foo2(a : Int32, b : Int64, s : String) {
        let v1 : Int32 = a
        let v2 : Int64 = b
        let v3 : String = s
    }

    foo2(-1, -2, "foo2")
    Assert.equals(10, v1)
    Assert.equals(11, v2)
    Assert.equals("bla-bla", v3)

// test case #3
    func foo4(a : Int64) : Int64 {
        let v2 : Int64 = a ** 2
        return v2
    }
    var foo4Var = foo4(12)
    Assert.equals(144,  foo4Var)
    Assert.equals(11,  v2)

// test case #4
    var num = 0
    try { 
        let num = - 5 
        throw ArithmeticException()
    } catch (e: ArithmeticException) {
        let num = -10
    }

    Assert.equals(0, num)
}
