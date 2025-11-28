/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:02_01_10_02_a39_19

  @Level:         1

  @Assertion: 2.1.10.2(39)
              It is not allowed to invoke a constructor via this outside of the constructor body.

  @Description: Check that this constuctors can not be called inside
                an instace member function without modifiers

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init() {}

    func f() {
        this()
    }
}

main() {
}