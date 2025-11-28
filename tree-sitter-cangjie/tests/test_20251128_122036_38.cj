/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a14_15

  @Level:         1

  @Assertion: 2.1.10.2(14)
              The members in the primary constructor can also be modified by using public or private.
              See Access Modifiers for details

  @Description: Check that a let member variable named parameter in the primary constructor
                modified with 'private' creates a variable that is not visible outside of the struct

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct Test {
    Test(private let x!: Int64) {}
}

main() {
    let tst = Test(x: 0)
    tst.x
}