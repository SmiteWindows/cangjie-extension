/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a04_02

  @Level:         1

  @Assertion:       2.1.10.5(4) In above, StructName is the name of the struct, and arguments is the list of argument.
                    StructName(arguments) will invoke the closest matching constructor (based on the rules in section
                    Function overloading Resolution), and then generate an instance of StructName.
                    let newRectangle1_1 = Rectangle1() // Invoke the constructor defined by the empty init block.
                    let newRectangle1_2 = Rectangle1(100, 200) // Invoke the first custom constructor.
                    let newRectangle1_3 = Rectangle1(300) // Invoke the second custom constructor.

  @Description:     Check that `StructName(arguments)` will invoke the closest matching constructor.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  ignore

*/

import utils.assert.Assert

var LAST_CALLED_CONSTRUCTOR_NUMBER = -1

open class Parent {}
class Child <: Parent {}

struct StructName {
    StructName(x: Child, y!: Parent) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 0
    }

    init() {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 1
    }

    init(x: Int64) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 2
    }

    init(x: Int64, y: Int64) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 3
    }

    init(x: Int64, y: Int32) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 4
    }

    init(x: Parent) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 5
    }

    init(x: Child) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 6
    }

    init(x: Parent, y: Parent) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 7
    }

    init(x: Child, y: Child) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 8
    }

    init(x: Parent, y: Child, z!: Bool = false) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 9
    }

    init(x: Parent, y: Parent, z: Parent) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 10
    }

    init(x: (Parent) -> Unit) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 11
    }

    init(x: (Child) -> Unit) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 12
    }

    init(x: (Parent) -> Unit, y: (Parent) -> Unit, z!: Bool = true) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 13
    }

    init(x: (Parent) -> Unit, y: (Child) -> Unit) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 14
    }

    init(x: (Child) -> Unit, y: (Child) -> Unit, z: (Child) -> Unit) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 15
    }

    init(x: (Child) -> Unit, y: Parent) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 16
    }

    init(x: (Parent) -> Unit, y: Child) {
        LAST_CALLED_CONSTRUCTOR_NUMBER = 17
    }
}

main() {
    StructName(Child(), y: Parent())
    Assert.equals(0, LAST_CALLED_CONSTRUCTOR_NUMBER)
    StructName(Child(), y: Child())
    Assert.equals(0, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName()
    Assert.equals(1, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(10)
    Assert.equals(2, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(10, 11)
    Assert.equals(3, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(10, 11i32)
    Assert.equals(4, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Parent())
    Assert.equals(5, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Child())
    Assert.equals(6, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Child(), Parent())
    Assert.equals(7, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Child(), Child())
    Assert.equals(8, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Parent(), Child())
    Assert.equals(9, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(Child(), Child(), Child())
    Assert.equals(10, LAST_CALLED_CONSTRUCTOR_NUMBER)

    func f1(x: Parent) {}
    func f2(x: Child) {}
    StructName(f1)
    Assert.equals(11, LAST_CALLED_CONSTRUCTOR_NUMBER)
    func f(x: Child) {}
    func f(x: Parent) {}
    StructName(f)
    Assert.equals(11, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f2)
    Assert.equals(12, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f1, f1)
    Assert.equals(13, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f1, f2)
    Assert.equals(14, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f1, f1, f1)
    Assert.equals(15, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f2, Parent())
    Assert.equals(16, LAST_CALLED_CONSTRUCTOR_NUMBER)

    StructName(f, Child())
    Assert.equals(17, LAST_CALLED_CONSTRUCTOR_NUMBER)
}
