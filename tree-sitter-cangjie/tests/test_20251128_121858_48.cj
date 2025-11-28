/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a40_17

  @Level:         1

  @Assertion: 2.1.10.2(40)
              If a constructor does not explicitly call other constructors,
              ensure that all instance member variables declared in this struct
              have been initialized before returned from the constructor.
              Otherwise, an error will be reported during compilation.

  @Description: Check that an error is produced if a private mutable instance variable
                is initialized only in one branch of an if expression inside the constructor

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init(a: Bool) {
        if (a) {
            x = 1
        }
    }

    private var x: Int64
}

main() {
}