/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a09_04

  @Level:         1
  @Assertion:       2.1.8.1(9) 
                    let range11 = 1..10 // Define an half-open range [1, 10) with step = 1.
                    let range12 = 1..=10 // Define a closed range [1, 10] with step = 1.
                    let range13 = ..10 // error: the start value is required.
                    let range14 = 1.. // error: the end value is required.
                    let range15 = .. // error: the start and end value are required.

  @Description:     Checks sample declarations.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

*/

main() {
  let range15 = .. // error: the start and end value are required.
  return 0
}
