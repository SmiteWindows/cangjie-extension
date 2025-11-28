/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_01_a02_02

  @Level:         1
  @Assertion:    2.2.1.1(2) Arrayliterals have the format of
                 [element1, element2, ..., elementN] , in which multiple
                 elements are separated by commas and each element can be an
                 expressionElement (i.e., general expression).

  @Description:  Checks that only values of same type can be used while array
                 creation

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    single

*/
func strFunc() {
    return "func result"
}

main(): Int64 {
    let a2: Array<String> = ["", "test", "A1 size = _",
        strFunc(), 189658i32]
    let b = 5 == a2.size

    return 0
}
