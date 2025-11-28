/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a07_03

  @Level:         1
  @Assertion:       2.1.11.1(7) A constructor with parameters has a function type, but it is not a first-class citizen.

  @Description:     Checks that parameterized enum constructor is not first-class functions

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/
enum A {
    B1(Bool) | B2(Int32, Rune)
}

main() {
   var f: (Bool) -> A = {b: Bool => if (b) {B1(b)} else {B2(0,'a')}}
   f = B1 //  error: undeclared identifier 'B1'
}
