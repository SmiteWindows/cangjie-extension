/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a02_02

  @Level:         1

  @Assertion:    2.1.6.2(2) When an interpolated string is resolved to a result string, items with interpolation expressions are replaced by the string representations of the expression results.

  @Description:  Check that when interpolated string is not resolved to a result string, items with interpolation expressions are not replaced by the string representations of the expression results

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert
public let testA0202: String = ###"${ 2 + 2 }"###
func myFunc() {
  #"
    ${"AA" }
  "#
}
main() {
  Assert.isTrue(testA0202 != "4")
  Assert.isTrue(testA0202 == "\${ 2 + 2 }")
  Assert.isTrue(myFunc() != #"
    AA 
  "#)
  Assert.isTrue(myFunc() == #"
    ${"AA" }
  "#)
}