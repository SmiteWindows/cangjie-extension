/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_02_a01_01

  @Level:         1
  @Assertion:       2.1.8.2(1) Range expressions can be used as a part of the for in expressions
                    (refer to Loop Expressions) or can be used as index for slicing.

  @Description:     Checks that range variables can be used as a part of the for in expressions.

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

import utils.assert.Assert

main() {
  var a1: Range<Int8>       = 0..10
  var a2: Range<Int16>      = -5..=10
  var a3: Range<Int32>      = 8..20:2
  var a4: Range<Int64>      = -3..=10:3
  var a5: Range<UInt8>     = 12..=10
  var a6: Range<UInt64>     = 80..130:22

  var range_str: String

  range_str = ""
  for (el in a1) {
    range_str += el.toString()
  }
  Assert.equals("0123456789", range_str)

  range_str = ""
  for (el in a2) {
    range_str += el.toString()
  }
  Assert.equals("-5-4-3-2-1012345678910", range_str)

  range_str = ""
  for (el in a3) {
    range_str += el.toString()
  }
  Assert.equals("81012141618", range_str)

  range_str = ""
  for (el in a4) {
    range_str += el.toString()
  }
  Assert.equals("-30369", range_str)

  range_str = ""
  for (el in a5) {
    range_str += el.toString()
  }
  Assert.equals("", range_str)

  range_str = ""
  for (el in a6) {
    range_str += el.toString()
  }
  Assert.equals("80102124", range_str)

  return 0
}
