/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:             02_01_11_02_a03_03

  @Level:         1

  @Assertion:        2.1.11.2(3) Note that since Cangjie supports type inference for generic parameters, 
  the generic parameter <T> can be omitted when accessed using both way 1 and way 2 above

  @Description:     Checks that generic parameter of enum must be specified if cannot be inferred 
  (empty constructor)

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

enum TimeUnit3<T1, T2> {
    | Year
    | Month(T1)
    | Day(T1, T2, T2)
    | Hour(T1, T2, T2, T2)
}
let time5 = Year

main() {
}
