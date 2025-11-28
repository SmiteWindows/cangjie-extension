/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a04_03

  @Level:         1

  @Assertion:       2.1.10.5(4) In above, StructName is the name of the struct, and arguments is the list of argument.
                    StructName(arguments) will invoke the closest matching constructor (based on the rules in section
                    Function overloading Resolution), and then generate an instance of StructName.
                    let newRectangle1_1 = Rectangle1() // Invoke the constructor defined by the empty init block.
                    let newRectangle1_2 = Rectangle1(100, 200) // Invoke the first custom constructor.
                    let newRectangle1_3 = Rectangle1(300) // Invoke the second custom constructor.

  @Description:     Check that an instance generates after a primary constructor invocation.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         To check honestly the phrase "StructName(arguments) will invoke the closest matching constructor,
                    and then generate an instance" by Cangjie means will most likely be impossible.

*/

import utils.assert.Assert

var INVOCATION_COUNTER = 0
var GENERATED_INSTANCE_COUNTER = 0

struct StructName {
    var v: Int64

    StructName() {
        INVOCATION_COUNTER++ // the invocation literally just happened along with the constructor invocation
        Assert.isTrue(INVOCATION_COUNTER == 1 && GENERATED_INSTANCE_COUNTER == 0)

        // Generating an instance.
        v = 0xffffffff

        // The instance has just been generated.
        confirmInstanceGeneration()
        Assert.isTrue(INVOCATION_COUNTER == 1 && GENERATED_INSTANCE_COUNTER == 1)
    }

    private func confirmInstanceGeneration() {
        // It's not possible to use `this` from a constructor until all member variables have been initialized.
        // Essentially, this is a compile-time check to see if an instance has been generated.
        if (this is StructName) {
            GENERATED_INSTANCE_COUNTER++
        }
    }
}

main() {
    let s = StructName()
    Assert.equals(4294967295, s.v)
}
