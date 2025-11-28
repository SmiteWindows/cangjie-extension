/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_01_a02_01

  @Level:         1
  @Assertion:    2.2.1.1(2) Arrayliterals have the format of
                 [element1, element2, ..., elementN] , in which multiple
                 elements are separated by commas and each element can be an
                 expressionElement (i.e., general expression).

  @Description:  Checks that array can be created specifying it's elements

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

func strFunc() {
    return "func result"
}

main(): Int64 {
    // let's check empty array can be constructed
    let a1: Array<Int32> = []
    Assert.equals(0, a1.size)
    Assert.isTrue(a1 is Array<Int32>)

    let a2: Array<String> = ["", "test", "A1 size = ${a1.size}",
        strFunc(), "str1" + " " + "str2"]
    Assert.equals(5, a2.size)
    Assert.isTrue(a2 is Array<String>)
    Assert.equals("test", a2[1])
    Assert.equals("str1 str2", a2[4])

    return 0
}
