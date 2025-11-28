/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a04_01

  @Level:         1

  @Assertion: 2.1.10.2(4)
              The primary constructor name is the same as the type name.

  @Description: Check that different types of structs can have a primary constructor
                with the same name as the struct

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

var constructor_counter = 0

struct JustAStruct {
    JustAStruct() {
        constructor_counter++
    }
}

struct AGenericStruct<T> {
    AGenericStruct() {
        constructor_counter++
    }
}

interface I {}
struct ImplementingStruct <: I {
    ImplementingStruct() {
        constructor_counter++
    }
}

struct StructWithInit {
    StructWithInit() {
        constructor_counter++
    }

    init(x: String) {}
}

main() {
    Assert.equals(0, constructor_counter)

    let case1 = JustAStruct()
    Assert.equals(1, constructor_counter)

    let case2 = AGenericStruct<Bool>()
    Assert.equals(2, constructor_counter)

    let case3 = ImplementingStruct()
    Assert.equals(3, constructor_counter)

    let case4 = StructWithInit()
    Assert.equals(4, constructor_counter)
}
