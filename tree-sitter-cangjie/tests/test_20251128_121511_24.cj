/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a04_01

  @Level:         1

  @Assertion:       2.1.10.5(4) In above, StructName is the name of the struct, and arguments is the list of argument.
                    StructName(arguments) will invoke the closest matching constructor (based on the rules in section
                    Function overloading Resolution), and then generate an instance of StructName.
                    let newRectangle1_1 = Rectangle1() // Invoke the constructor defined by the empty init block.
                    let newRectangle1_2 = Rectangle1(100, 200) // Invoke the first custom constructor.
                    let newRectangle1_3 = Rectangle1(300) // Invoke the second custom constructor.

  @Description:     Check that `StructName(arguments)` will invoke the constructor.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

var INVOCATION_COUNTER = 0

struct StructName {
    init(arg1: Int64, arg2: Int64) {
        INVOCATION_COUNTER++
    }
}

main() {
    let beforeInvocation = INVOCATION_COUNTER
    StructName(1, 2)
    Assert.equals(1, INVOCATION_COUNTER - beforeInvocation)
}
