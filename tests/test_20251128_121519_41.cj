/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_01_a02_03

  @Level:         1
  @Assertion:    2.2.1.1(2) Arrayliterals have the format of
                 [element1, element2, ..., elementN] , in which multiple
                 elements are separated by commas and each element can be an
                 expressionElement (i.e., general expression).

  @Description:  Checks that only values of type having same supertype can be
                 used while array creation

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    complex-main
  @Dependencies: ../../array_commons.cj

*/
import array_commons.*

func objFunc() {
    return C1()
}

main(): Int64 {
    let a2: Array<I> = [C2(), C3(), objFunc(),
        CM2()]
    let b = 4 == a2.size

    return 0
}
