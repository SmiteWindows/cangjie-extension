/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a30_41

  @Level:         1

  @Assertion: 2.1.10.2(30)
              In addition to the primary constructor, it is possible to define user-defined constructors,
              which are defined by starting with the keyword init and followed
              by the parameter list and the function body.

  @Description: Check that a constructor can not be defined with the 'mut' keyword

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    mut(a: Int64) {
        this.x = a
    }

    let x: Int64
}

main() {
}
