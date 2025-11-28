/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a11_01

  @Level:         1

  @Assertion:       2.1.11.1(11) For example:
 enum TimeUnit4 {
  | Year
  | Year(Int32) // ok
  | Year(Float32) // error: redeclaration of 'Year'
  | Month(Int32, Float32) // ok
  | Month(Int32, Int32) // error: redeclaration of 'Month'
  | Month(Int32) // ok
  | Day(Int32, Float32, Float32) // ok
  | Day(Float32, Float32, Float32) // error: redeclaration of 'Day'
  | Day(Float32, Float32) // ok
  | Hour(Int32, Float32, Float32, Float32) // ok
  | Hour(Int32, Int32, Int32, Int32) // error: redeclaration of 'Day'
  | Hour(Int32, Int32, Int32) // ok
 }


  @Description:     Checks that positive examples compile

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single

  @Comment:

*/

 enum TimeUnit4 {
  | Year
  | Year(Int32) // ok
  | Month(Int32, Float32) // ok
  | Month(Int32) // ok
  | Day(Int32, Float32, Float32) // ok
  | Day(Float32, Float32) // ok
  | Hour(Int32, Float32, Float32, Float32) // ok
  | Hour(Int32, Int32, Int32) // ok
 }

main() {
}
