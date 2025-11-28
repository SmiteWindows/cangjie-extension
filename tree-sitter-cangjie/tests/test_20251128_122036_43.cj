/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a22_10

  @Level:         1

  @Assertion: 2.1.10.2(22)
              The sequence of the parameters of the primary constructor 
              must follow the parameter sequence when the function is defined.
              Non-named parameters must precede all named parameters.

  @Description: Check that a var member variable named parameter can not be placed
                before a var member variable unnamed parameter

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006183

*/

struct A {
    A(var a!: Int64, var b: Int64) {}
}

main() {
}