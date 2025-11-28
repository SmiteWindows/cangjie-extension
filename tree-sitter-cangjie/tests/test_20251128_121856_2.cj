/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a23_04

  @Level:         1

  @Assertion: 2.1.10.2(23)
              Main constructor body: The primary constructor does not allow calls to other constructors in this struct

  @Description: Check that the primary constructor without parameters can not call another constructor

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A() {
        this(15)
    }

    init(x: Int64) {}
}

main() {
}