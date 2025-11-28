/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a06_08

  @Level:         1

  @Comment: This assertion is a part of the list with the following heading:
            A primary constructor definition includes the following:

  @Assertion: 2.1.10.2(6)
              Parameter list: The primary constructor name is followed by a parameter list.

  @Description: Check that a parameter list with member variable unnamed parameters
                can not precede the primary constructor name

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    public (private let x: Int64, var b: String) A {}
}

main() {
}
