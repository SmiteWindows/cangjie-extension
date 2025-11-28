/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a37_01

  @Level:         1

  @Assertion: 2.1.10.2(37)
              It is allowed to invoke other constructors via this in a constructor.

  @Description: Check that another constructor can be called inside a constructor

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

var order = ""


struct Test {
    init() {
        order += "_1"
    }
    init(x: Int64) {
        this()
        order += "_2"
    }
    init(x: Int64, y: Int64) {
        this(x)
        order += "_3"
    }
    init(x: Int64, y: Int64, z: Int64) {
        this(x, y)
        order += "_4"
    }
    init(x1: Int64, x2: Int64, x3: Int64, x4: Int64) {
        this(x1, x2, x3)
        order += "_5"
    }
}

struct TestG<T> {
    init() {
        order += "_1"
    }
    init(x: Rune) {
        this()
        order += "_2"
    }
    init(x: T) {
        this(r'a')
        order += "_3"
    }
}

main() {
    let case1 = Test(1, 2, 3, 4)
    Assert.equals("_1_2_3_4_5", order)

    order = ""
    let case2 = TestG<Float64>(0.01)
    Assert.equals("_1_2_3", order)
}