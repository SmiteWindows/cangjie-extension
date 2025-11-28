/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a09_02

  @Level:         1
  @Assertion:       2.1.11.1(9) As custom types, enum types do not support == (and ! =) by default. Of course, it is
possible to override the == (or ! =) operator (see Section operator overloading) to make custom
enum types support == (or ! =).

  @Description:     Checks that enum types do not support != by default

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

enum E {
    | F
}
let c = F != F

main() {
}
