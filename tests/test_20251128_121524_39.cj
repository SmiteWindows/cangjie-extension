/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a08_12

  @Level:         1

  @Assertion: 2.1.10.2(8)
              The syntax and semantics of regular parameters are consistent 
              with those in the function definition.

  @Description: Check that a regular unnamed parameter of type IntNative can not accept
                an arguments of a different type

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A(x: IntNative) {}
}

main() {
    let a = A(())
}
