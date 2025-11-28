/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a12_03

  @Level:         1
  @Assertion:       2.1.11.1(12) It is supported to define recursive and mutually recursive enum types.

  @Description:     Checks that enum constructor is not accepted as argument type

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/
enum E {
    E1 | E2(E1) | E3(E2)
}

main() {
}
