/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a16_02

  @Level:         1

  @Assertion: 2.1.10.2(16)
              The member variable defined in the primary constructor
              cannot have the same name as those outside the primary constructor.

  @Description: Check that a public var member variable unnamed parameter
                can not have the same name as a struct member variable

  @Mode: compileonly

  @Negative: yes

  @Structure: single


*/

struct Test {
    Test(public var a: Int64) {}

    var a = 1
}

main() {
}