/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a21_53

  @Level:         1

  @Assertion: 2.1.10.2(21)
              Regular parameters must precede all member variable parameters.

  @Description: Check that a public let unnamed member variable parameter
                can not be placed between a regular unnamed parameter 
                and a regular named parameter

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A(c: Bool, public let a: Int64, b!: Bool) {}
}

main() {
}