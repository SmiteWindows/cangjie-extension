/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a44_01

  @Level:         1

  @Assertion: 2.1.10.2(44)
              If the one of the instance member variables of the struct have no initial value,
              an error is reported during compilation.

  @Description: Check that a struct can have an implicit constructor
                if all the member variables have initial values

  @Mode: run

  @Negative: no

  @Structure: single

  @Comment: This is the continuation of the previous assertion:
            "If neither the primary constructor nor the init constructor is defined for a struct,
            the compiler attempts to generate a (public modified) parameterless constructor."
            So it only applies to implicit constructors

*/

import utils.assert.Assert

struct A {
    var x = 1
    var y = 2
}

struct B {}

struct C {
    public let a = ""
    public var b = 'a'
    private let c = -0.15
    private var d = (9, 9)
    let e = [1, 2, 3]
    var f = { => 1}
}


main() {
    let case1 = A()
    Assert.isTrue(case1 is A)

    let case2 = B()
    Assert.isTrue(case2 is B)

    let case3 = C()
    Assert.isTrue(case3 is C)
}