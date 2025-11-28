/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a12_04

  @Level:         1

  @Assertion:       2.1.11.2(12) 
 package p
 var A = 0 // conflict with A
 var F: (Int64)->Int64 = { i => i } // conflict with F
 
 enum E {
  | A // conflict with A
  | F(Int64) // conflict with F
 }
 enum R {
  | C(Int64) // conflict with C
 }
 enum C { // conflict with C
  | B
 }
 func g() {
  let a = A // error
  let b = E.A // ok
  let c = p.A // ok
  F(1) // error
  E.F(1) // ok
  p.F(1) // ok
  let x: C // error
  let y: p.C // ok
 }

  @Description:     Checks that negative examples fail compilation

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single

  @Comment:

*/
package p

var A = 0 // conflict with A

enum E {
    | A // conflict with A
}
func g() {
    let a = A // error
}

main() {
}
