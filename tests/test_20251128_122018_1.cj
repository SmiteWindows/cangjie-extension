/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_a04_01

  @Level:         1
  @Assertion:       2.1.8(4) Each instance of type Range<T> will contain three values, i.e.,
                    start, end and step. Where start and end represent the start and end values
                    of the sequence, respectively, and step represents the difference between
                    two adjacent elements in the sequence.

  @Description:     Checks that the first value of half-open range sequence is start and the differens is step.

  @Mode:            run
  @Negative:        no
  @Structure:       single

*/

import utils.assert.Assert

func range<T>(a: T, b: T, c: Int64): Range<T> where T <: Countable<T> & Comparable<T> {
  a..b:c
}

func check_range(a: Int64, b: Int64, c: Int64): Bool {
  let r = range(a, b, c)
  var first: Bool = true
  var prev: Int64 = 0
  for (el in r) {
    if (first) {
      if (a != el) {
        return false
      }
      first = false
    } else {
      if (c != el - prev) {
        return false
      }
    }
    prev = el
  }
  true
}

main() {
  for (a in -15..=15) {
    for (b in -15..=15) {
      for (c in -3..=3) {
        if (c != 0) {
          Assert.isTrue(check_range(a, b, c))
        }
      }
    }
  }
  return 0
}
