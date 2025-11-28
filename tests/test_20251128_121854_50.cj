/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_a03_02

  @Level:         1
  @Assertion:       2.1.8(3) Range is an immutable type that represents an sequence of elements
                    with fixed step value.

  @Description:     Checks that difference between sequence elements is fixed.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

*/

import utils.assert.Assert

main() {

  let r1 = 0..10
  let r2 = -100i32..-33i32:11
  let r3 = 35u8..13u8:-7
  
  var diff: Int64
  var first: Bool
  diff = 0
  first = true
  for (el in r1) {
    if (first) {
      first = false
    } else {
      if (diff == 0) {
        Assert.notEquals(0, el - prev)
        diff = el - prev
      } else {
        Assert.equals(diff, el - prev)
      }
    }
    prev = el
  }
  diff = 0
  first = true
  for (el in r2) {
    if (first) {
      first = false
    } else {
      if (diff == 0) {
        Assert.notEquals(0, el - prev)
        diff = el - prev
      } else {
        Assert.equals(diff, el - prev)
      }
    }
    prev = el
  }
  diff = 0
  first = true
  for (el in r3) {
    if (first) {
      first = false
    } else {
      if (diff == 0) {
        Assert.notEquals(0, el - prev)
        diff = el - prev
      } else {
        Assert.equals(diff, el - prev)
      }
    }
    prev = el
  }
  return 0
}
