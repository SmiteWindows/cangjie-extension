/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_02_a03_01

  @Level:         1
  @Assertion:       2.1.8.2(3) The values of ommited item are determined by the context in which
                    the instance is used: when the operator [] is overloaded on a custom type and
                    its parameter type is Range<Int64>, the value of start equals 0 when start is
                    omitted, and the value of end equals the maximum value of Int64.

  @Description:     Checks the values of range start/end when omitted.

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

import utils.assert.Assert

main() {

  let array = [-3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8]

  Assert.equals([-3, -2, -1, 0, 1], array[..=4])
  Assert.equals([7, 8], array[10..])
  Assert.equals([2, 3, 4, 5, 6, 7, 8], array[5..])
  Assert.equals([-3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8], array[..])
  return 0
}
