/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:02_01_10_02_a24_27

  @Level:         1

  @Assertion: 2.1.10.2(24)
              Declarations and expressions are allowed in the primary constructor body
              but must meet the requirements of init constructors.

  @Description: Check that all mutable variables have to be initialized
                in the primary constructor

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Comment: From the description in the init constructor section:
            If a constructor does not explicitly call other constructors,
            ensure that all instance member variables declared in this struct
            have been initialized before returned from the constructor.
            Otherwise, an error will be reported during compilation.

*/

struct A {
    A() {}

    var a: Int64
}

main() {
}