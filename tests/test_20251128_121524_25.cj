/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a29_06

  @Level:         1

  @Assertion: 2.1.10.2(29)
              In addition to the primary constructor,
              other constructors can be defined as usual,
              but the other constructors must form an overload
              with the corresponding constructor of the primary constructor.

  @Description: Check that a struct can not have a primary constructor
                and an init constructor with the same signature:
                parameters in the primary constructor are member variable parameters

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A(private let x: Int64) {}
    init(x: Int64) {
        this.x = 1
    }
}

main() {
}