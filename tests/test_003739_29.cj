/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a01_03

  @Level:         1

  @Assertion:    3.2.3.2(1) Names defined inside a function definition or an expression have local-level scope.

  @Description:  Checks that variables defined in function have local-level scope.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

func f1() {
  var a = 1
  return a
}

func f2() {
  var a = 2
  return a
}

var b = 33

func f3() {
  var b = 3
  return b
}

func f4(callNested: Bool) {
  var c = 4
  func nested() {
    var c = 44
    return c
  }

  if (callNested == true) {
    return nested()
  }
  return c
}

main() {
  Assert.equals(1, f1())
  Assert.equals(2, f2())
  Assert.equals(3, f3())
  Assert.equals(33, b)
  Assert.equals(4, f4(false))
  Assert.equals(44, f4(true))
}
