/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a36_05

  @Level:         1

  @Assertion: 2.1.10.2(36)
              Also, this cannot be used as a separate expression.

  @Description: Check that 'this' can not be used to initialize
                a mutable instance variable with the 'public' access modifier

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct Test {
    init() {
        x = this
    }

    public var x: Test
}

main() {
}