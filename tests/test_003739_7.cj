/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a08_02

  @Level:         1
  @Assertion:       2.1.11.1(8)  For example:
 enum E {
  | mkE // OK. The type of mkE is E but not () -> E.
  | mkE() // Syntax error.
 }
 
 enum E1 {
  | A
 }
 let a = A // ok, a: E1
  
 enum E2 {
  | B(Bool)
 }
 let b = B // error
 enum E3 {
  | C
  | C(Bool)
 }
 let c = C // ok, c: E3

  @Description:     Checks that negative examples do not compile

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

enum E {
    | mkE // OK. The type of mkE is E but not () -> E.
    | mkE() // Syntax error.
}

main() {
}
