/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a07_03

  @Level:         1

  @Assertion:       2.1.11.2(7) As long as more than one enum constructor passes the type check, it is unresolvable.

  @Description:     Checks that conflicting parameter constructors produce compilation error

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

enum E1 {
    | F
    | F(Bool)
    | F(Rune, Int8)
}
enum E2 {
    F
    | F(Bool)

}

let a = F(true)

main() {
}
