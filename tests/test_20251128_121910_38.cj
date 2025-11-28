/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a02_01

  @Level:         1
  @Assertion:   3.2.3.1(2) The scope of top-level functions, types (including class, interface, enum, struct, and type)
                is the entire package, and thus they are accessible in the entire package.
                level, local-level, and type-internal.
  @Mode:        run
  @Negative:    no
  @Structure:   complex-main
  @Dependencies: ext1_a02.cj

*/

package somepackage

import utils.assert.Assert

let strTest1 = str1
let chTest1 = ch1
var numTest1 = num1
var boolTest1 = bool1

let tupleTest1 = tuple1
var rangeTest1 = range1

func foo() {
  Assert.equals("qwerty", str1)
  Assert.equals('i', ch1)
  Assert.equals(630002, num1)
  Assert.equals(true, bool1)
  Assert.equals('c', tuple1[0])
  Assert.equals(99, tuple1[1])
  Assert.equals(0..11:3, range1)
  return str1
}

main() {
  Assert.equals("qwerty", str1)
  Assert.equals("qwerty", strTest1)

  Assert.equals('i', ch1)
  Assert.equals('i', chTest1)

  Assert.equals(630002, num1)
  Assert.equals(630002, numTest1)

  Assert.equals(true, bool1)
  Assert.equals(true, boolTest1)

  Assert.equals('c', tuple1[0])
  Assert.equals(99, tuple1[1])
  Assert.equals('c', tupleTest1[0])
  Assert.equals(99, tupleTest1[1])

  Assert.equals(0..11:3, range1)
  Assert.equals(0..11:3, rangeTest1)

  Assert.equals("qwerty", foo())
  return 0
}
