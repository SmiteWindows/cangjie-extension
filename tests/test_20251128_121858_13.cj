/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a44_06

  @Level:         1

  @Assertion: 2.1.10.2(44)
              If the one of the instance member variables of the struct have no initial value,
              an error is reported during compilation.

  @Description: Check that an error is produced if a struct does not have an explicit constructor
                and there is a private immutable member variable without an initial value

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Comment: This is the continuation of the previous assertion:
            "If neither the primary constructor nor the init constructor is defined for a struct,
            the compiler attempts to generate a (public modified) parameterless constructor."
            So it only applies to implicit constructors

*/

struct A {
    private let x: Int64
}

main() {
}