/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a03_19

  @Level:         1

  @Comment: This assertion is a part of the list with the following heading:
            A primary constructor definition includes the following:

  @Assertion: 2.1.10.2(3)
              Modifier: optional. Primary constructors can be modified with one of
              public or private, none of which are visible within the package.
              See Access Modifiers for details

  @Description: Check that a public primary constructor is not visible within the package
                through the struct type

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006179

  @Comment: I interpret the "none of which are visible within the package" as
            "primary constructors can not be accessed as struct members"
            But these tests might be incorrect. Wait for the resolution of 0006179

*/

struct A {
    public A() {}
}

main() {
    A.A()
}
