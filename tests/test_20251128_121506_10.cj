/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a04_03

  @Level:         1
  @Assertion:       2.1.8.1(4) The expression start..=end:step returns an empty range instance
                    if step > 0 and start > end, or step < 0 and start < end. When the result of
                    start..=end:step is non-empty, the number of elements in the range instance
                    is equal to the floor of ((end-start)/step)+1 (i.e., the greatest integer
                    less than or equal to ((end-start)/step)+1).

  @Description:     Checks that size of range is equal to the floor of (end-start)/step + 1.

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

import utils.assert.Assert

func floor(a: Int64, b: Int64, c: Int64) : Int64 {
  var res = (b - a) / c + 1
  res
}

func rangeSize(range: Range<Int64>) : Int64 {
  var size: Int64 = 0
  for (el in range) {
    size += 1
  }
  size
}

main() {
  Assert.equals(floor(2, 10, 3), rangeSize(2..=10:3))
  Assert.equals(floor(20, 5, -5), rangeSize(20..=5:-5))
  Assert.equals(floor(-7, -2, 2), rangeSize(-7..=-2:2))
  Assert.equals(floor(-10, -20, -4), rangeSize(-10..=-20:-4))
  
  for (a in -10..10) {
    for (b in -20..20) {
      for (c in -5..5) {
        if (c != 0) {
          if (rangeSize(a..=b:c) > 0) {
            Assert.equals(floor(a, b, c), rangeSize(a..=b:c))
          }
        }
      }
    }
  }
  return 0
}
