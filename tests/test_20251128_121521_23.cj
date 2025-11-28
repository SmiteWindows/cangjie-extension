/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a33_13

  @Level:         1

  @Assertion: 2.1.10.2(33)
              Not allowed to use the instance member variable this.variableName
              and its syntax sugar variableName
              as the default value of constructor parameters.

  @Description: Check that an initialized immutable member variable
                can not be used through 'this' as the default value of constructor parameters

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init(p!: Int64 = this.x) {
    }

    let x = 1
}

main() {
}