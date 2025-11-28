/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_03_a02_01

  @Level:         1
  @Assertion:       2.1.8.3(2) 
                    let range16: Range<Int64> = 0..10 // Define an half-open range [0,10) with step = 1
                    let range17: Range<Int64> = -10..10:2 // Define an half-open range [-10,10) with step = 2
                    let range18 = 0..=10 // Define a closed range [0,10] with step = 1
                    let range19 = -10..=10:2 // Define a closed range [-10,10] with step = 2

  @Description:     Checks that declarations work as expected.

  @Mode:            run
  @Negative:        no
  @Structure:       single

*/

import utils.assert.Assert

main() {
  var range_str: String
  let range16: Range<Int64> = 0..10 // Define an half-open range [0,10) with step = 1
  range_str = ""
  for (el in range16) {
    range_str += el.toString()
  }
  Assert.equals("0123456789", range_str)

  let range17: Range<Int64> = -10..10:2 // Define an half-open range [-10,10) with step = 2
  range_str = ""
  for (el in range17) {
    range_str += el.toString()
  }
  Assert.equals("-10-8-6-4-202468", range_str)

  let range18 = 0..=10 // Define a closed range [0,10] with step = 1
  range_str = ""
  for (el in range18) {
    range_str += el.toString()
  }
  Assert.equals("012345678910", range_str)

  let range19 = -10..=10:2 // Define a closed range [-10,10] with step = 2
  range_str = ""
  for (el in range19) {
    range_str += el.toString()
  }
  Assert.equals("-10-8-6-4-20246810", range_str)

  return 0
}
