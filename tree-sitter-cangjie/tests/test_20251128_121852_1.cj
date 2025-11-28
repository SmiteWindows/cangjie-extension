/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:02_01_10_02_a35_08

  @Level:         1

  @Assertion: 2.1.10.2(35)
              Inside constructor, this cannot be captured in lambda expressions and nested functions.

  @Description: Check that 'this' can not be captured through a member property
                by a nested function in the init constructor

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006485, 0006124

*/

struct A {
    init() {
        func local() {
            p
            return 1
        }
        local()
    }
    prop p: Int64 {
        get() {
            10
        }
    }
}

main() {
}