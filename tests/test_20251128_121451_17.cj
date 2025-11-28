/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a09_57

  @Level:         1

  @Assertion: 2.1.10.2(9)
              The member variable parameter is introduced to reduce code redundancy.
              Defines a member variable parmeter, including the definitions of both a parameter
              and a member variable.

  @Description: Check that a member variable named parameter can not be placed
                in between regular unnamed parameters

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006183

  @Comment: Excerpt from 5.1.2 Parameters:
            When the function is declared, non-named parameters must precede all named parameters.

*/

struct A {
    A(a: Int64, let x!: Int64, y: Int64, var b!: Int64) {}
}

main() {
}
