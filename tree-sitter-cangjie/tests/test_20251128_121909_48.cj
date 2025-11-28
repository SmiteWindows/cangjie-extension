/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a33_15

  @Level:         1

  @Assertion: 2.1.10.2(33)
              Not allowed to use the instance member variable this.variableName
              and its syntax sugar variableName
              as the default value of constructor parameters.

  @Description: Check that an uninitialized private mutable member variable
                can not be used directly as the default value of constructor parameters

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init(p!: Int64 = x) {
        this.x = 1
    }

    private var x: Int64
}

main() {
}