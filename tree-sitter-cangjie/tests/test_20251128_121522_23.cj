/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a01_03

  @Level:         1
  @Assertion:   3.2.3.1(1) Names declared or defined at the top-level of a source file (i.e., not enclosed in {}) 
                have top-level scope.
                and vice versa.
  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.Assert

let str1 = "abcdf"
var str2 = str1

var ch1 = 'p'
let ch2 = ch1

open class X {
  var str3 = str1
  let ch3 = ch1
}

main() {
  
  Assert.equals("abcdf", str1)
  Assert.equals("abcdf", str2)

  Assert.equals('p', ch1)
  Assert.equals('p', ch2)

  let xObj2 = X()
  Assert.equals("abcdf", xObj2.str3)
  Assert.equals('p', xObj2.ch3)
  return 0
}