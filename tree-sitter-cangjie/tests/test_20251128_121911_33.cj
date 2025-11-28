/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a09_23

  @Level:         1

  @Assertion: 2.1.10.2(9)
              The member variable parameter is introduced to reduce code redundancy.
              Defines a member variable parmeter, including the definitions of both a parameter
              and a member variable.

  @Description: Check that a member variable unnamed parameter that has a tuple type can not accept
                an arguments of a different type

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006183

*/

struct A {
    A(var x: (Int64, Int32)) {}
}

main() {
    let a = A(())
}
