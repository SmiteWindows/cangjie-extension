/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_01_a05_01

  @Level:         1
  @Assertion:    2.2.1.1(5) When the context does require a specific type, then
                 the type of all the element must be a subtype of the specific
                 element type required by the context.

  @Description:  Checks that array type is set based on context

  @Mode:         run
  @Negative:     no
  @Structure:    complex-main
  @Dependencies: ../../array_commons.cj

*/
import utils.assert.*
import array_commons.*

func test(a1: Array<I>) {
    Assert.isTrue(a1 is Array<I>)
}

main(): Int64 {
    test([C1(), C2(), C3()])

    return 0
}
