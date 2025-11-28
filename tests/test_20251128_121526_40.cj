/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a43_08

  @Level:         1

  @Assertion: 2.1.10.2(43)
              If neither the primary constructor nor the init constructor is defined for a struct,
              the compiler attempts to generate a (public modified) parameterless constructor.

  @Description: Check that a struct without explicit constructor does not have
                a consctructor with one Object parameter

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {}

main() {
    A(Object())
    0
}