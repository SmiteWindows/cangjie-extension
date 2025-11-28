/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_a02_01

  @Level:         1

  @Assertion:       2.1.11(2) A value of an enum type can only take one of these constructors at any time.


 
  @Description:     Checks that constructors cannot be applied more than once

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/
enum E { |A(Int64) | B(Rune)}

main() {
    var e = A(0).B('a')
}
