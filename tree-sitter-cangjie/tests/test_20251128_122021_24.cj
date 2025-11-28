/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:             02_01_11_02_a02_01

  @Level:         1

  @Assertion:        2.1.11.2(2) The second way is to omit the enum name, for example:
 let time4 = Year // syntax sugar of 'TimeUnit1.Year'
 let time5 = Month(1.0, 2.0) // syntax sugar of 'TimeUnit2.Month(1.0, 2.0)'
 let time6 = Day<Int64, Float64>(1, 2.0, 3.0) // syntax sugar of 'TimeUnit3<Int64, Float64>.Day(1, 2.0, 3.0)'

  @Description:     Checks that positive examples compile

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

enum TimeUnit1 {
    Year
}
enum TimeUnit2 {
    | Year(Float32)
    | Month(Float32, Float32)
    | Day(Float32, Float32, Float32)
    | Hour(Float32, Float32, Float32, Float32)
}
 
enum TimeUnit3<T1, T2> {
    | Year(T1)
    | Day(T1, T2, T2)
    | Hour(T1, T2, T2, T2)
}
let time4 = Year // syntax sugar of 'TimeUnit1.Year'
let time5 = Month(1.0, 2.0) // syntax sugar of 'TimeUnit2.Month(1.0, 2.0)'
let time6 = Day<Int64, Float64>(1, 2.0, 3.0) // syntax sugar of 'TimeUnit3<Int64, Float64>.Day(1, 2.0, 3.0)'

main() {
}
