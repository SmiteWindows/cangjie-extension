/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a05_03

  @Level:         1
  @Assertion:       2.1.11.1(5) enum types can only be defined at top-level.

  @Description:     Checks that enum cannot be defined within class definition

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/
class C {
    enum A {
       B
    }
}
main() {
}
