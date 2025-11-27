/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a42_01

  @Level:         1

  @Assertion: 2.1.10.2(42)
              The return type of the constructor is Unit type.

  @Description: Check that constructors can have an explicit return statement
                if the expression is of the Unit type

  @Mode: run

  @Negative: no

  @Structure: single

  @Issue: 0006502

*/

import utils.assert.Assert

var id = 0

func unit_f() {
    return ()
}

struct Test {
    init() {
        id = 1
        return
    }

    init(x: Int64) {
        id = 2
        return ()
    }

    init(x: String) {
        id = 3
        let a: Unit = ()
        return a
    }

    init(x: Rune) {
        id = 4
        var a = 1
        return (a = 0)
    }

    init(x: Bool) {
        id = 5
        var a = 1
        return a++
    }

    init(x: Unit) {
        id = 6
        return x
    }

    init(x: Float64) {
        id = 7
        return unit_f()
    }
}

main() {
    let t1 = Test()
    Assert.equals(1, id)

    let t2 = Test(1)
    Assert.equals(2, id)

    let t3 = Test("")
    Assert.equals(3, id)

    let t4 = Test(r'a')
    Assert.equals(4, id)

    let t5 = Test(true)
    Assert.equals(5, id)

    let t6 = Test(())
    Assert.equals(6, id)

    let t7 = Test(1.1)
    Assert.equals(7, id)
}