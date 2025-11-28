/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a24_47

  @Level:         1

  @Assertion: 2.1.10.2(24)
              Declarations and expressions are allowed in the primary constructor body
              but must meet the requirements of init constructors.

  @Description: Check that a static let struct member variable definition is not allowed
                in the primary constructor body

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A() {
        static let x = 1
    }
}

main() {
}