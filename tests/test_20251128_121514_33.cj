/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a12_03

  @Level:         1

  @Assertion: 2.1.10.2(12)
              The syntax of the member variable parameter is the same as that
              defined outside the primary constructor.

  @Description: Check that the keyword var or let can not be omitted
                when defining a member variable parameter modified with private

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    A(private x: Int64) {}
}

main() {
}