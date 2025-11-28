/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a14_01

  @Level:         1

  @Assertion:       2.1.11.2(14) 
enum E<T> {
   | A(T)
   | B(T)
  }
  func f() {
   let a = A(1) // ok, a: E<Int64>
   let b = A<Int32>(2) // ok, b: E<Int32>
  }
  @Description:     Checks that positive examples do compile

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

enum E<T> {
   | A(T)
   | B(T)
  }
  func f() {
   let a = A(1) // ok, a: E<Int64>
   let b = A<Int32>(2) // ok, b: E<Int32>
  }
main() {
}
