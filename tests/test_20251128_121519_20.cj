/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a01_01

  @Level:         1

  @Assertion: 2.1.10.2(1)
              In Cangjie programming language, there are two types of struct constructors:
              primary constructor and init constructor.

  @Description: Check that a struct can have a primary constructor and init constructors

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

var constructor_counter = 0
var last_executed_constructor = ""

struct NonGeneric {
    NonGeneric() {
        constructor_counter++
        last_executed_constructor = "NonGeneric.Primary"
    }
    init(x: Int64) {
        constructor_counter++
        last_executed_constructor = "NonGeneric.init(Int64)"
    }
    init(a: String, b: String) {
        constructor_counter++
        last_executed_constructor = "NonGeneric.init(String, String)"
    }
}

struct Generic<T> {
    public Generic(a: Bool, b: Rune, c: Float64) {
        constructor_counter++
        last_executed_constructor = "Generic.Primary"
    }

    init() {
        constructor_counter++
        last_executed_constructor = "Generic.init()"
    }

    init(x: Bool) {
        constructor_counter++
        last_executed_constructor = "Generic.init(Bool)"
    }

    init(x: Rune) {
        constructor_counter++
        last_executed_constructor = "Generic.init(Rune)"
    }

    init(x: String) {
        constructor_counter++
        last_executed_constructor = "Generic.init(String)"
    }

    init(x: Int64) {
        constructor_counter++
        last_executed_constructor = "Generic.init(Int64)"
    }
}

main() {
    Assert.equals(0, constructor_counter)

    var case1 = NonGeneric()
    Assert.equals(1, constructor_counter)
    Assert.equals("NonGeneric.Primary", last_executed_constructor)

    var case2 = NonGeneric(76)
    Assert.equals(2, constructor_counter)
    Assert.equals("NonGeneric.init(Int64)", last_executed_constructor)

    var case3 = NonGeneric("", "")
    Assert.equals(3, constructor_counter)
    Assert.equals("NonGeneric.init(String, String)", last_executed_constructor)

    var case4 = Generic<Unit>(false, r'a', 0.5)
    Assert.equals(4, constructor_counter)
    Assert.equals("Generic.Primary", last_executed_constructor)

    var case5 = Generic<Bool>()
    Assert.equals(5, constructor_counter)
    Assert.equals("Generic.init()", last_executed_constructor)

    var case6 = Generic<Int32>(true)
    Assert.equals(6, constructor_counter)
    Assert.equals("Generic.init(Bool)", last_executed_constructor)

    var case7 = Generic<Float32>(r'a')
    Assert.equals(7, constructor_counter)
    Assert.equals("Generic.init(Rune)", last_executed_constructor)

    var case8 = Generic<String>("1")
    Assert.equals(8, constructor_counter)
    Assert.equals("Generic.init(String)", last_executed_constructor)

    var case9 = Generic<(Unit, Unit, Unit)>(3)
    Assert.equals(9, constructor_counter)
    Assert.equals("Generic.init(Int64)", last_executed_constructor)
}
