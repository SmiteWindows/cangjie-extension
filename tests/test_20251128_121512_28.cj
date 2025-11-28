/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a03_02

  @Level:         1
  @Assertion:   3.2.3.1(3) Top-level variables, whose names are introduced by let and var are only accessible 
                after they are defined (including the initialization) in the same source file, 
                but in the other files of the same package can be accessible.
                and type-internal.
  @Mode:        run
  @Negative:    no
  @Structure:   complex-main
  @Dependencies: ext1_a03.cj

*/

package somepackage

import utils.assert.Assert

var strTest2 = str2
var chTest2 = ch2
var numTest2 = num2
var boolTest2 = bool2
var tupleTest2 = tuple2
var rangeTest2 = range2
var structTest2 = struct2
var arrTest2 = arr2

func foo() {
  Assert.equals("fdcba", str2)
  Assert.equals('o', ch2)
  Assert.equals(14.3, num2)
  Assert.equals(false, bool2)
  Assert.equals('b', tuple2[0])
  Assert.equals(98, tuple2[1])
  Assert.equals(0..11:2, range2)
  Assert.equals(1, struct2.a)
  Assert.equals(2, struct2.b)
  Assert.equals(8, arr2[2])
  return str2
}

main() {
  Assert.equals("fdcba", str2)
  Assert.equals("fdcba", strTest2)

  Assert.equals('o', ch2)
  Assert.equals('o', chTest2)

  Assert.equals(14.3, num2)
  Assert.equals(14.3, numTest2)

  Assert.equals(false, bool2)
  Assert.equals(false, boolTest2)

  Assert.equals('b', tuple2[0])
  Assert.equals(98, tuple2[1])
  Assert.equals('b', tupleTest2[0])
  Assert.equals(98, tupleTest2[1])

  Assert.equals(0..11:2, range2)
  Assert.equals(0..11:2, rangeTest2)

  Assert.equals(struct2.a, structTest2.a)
  Assert.equals(struct2.b, structTest2.b)

  Assert.equals(arr2, arrTest2)

  Assert.equals("fdcba", foo())
  return 0
}
