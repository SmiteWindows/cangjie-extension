/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a02_01

  @Level:         1

  @Assertion:    2.1.6.2(2) When an interpolated string is resolved to a result string, items with interpolation expressions are replaced by the string representations of the expression results.

  @Description:  Check different variants of interpolated strings

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      Need more variants

*/
import utils.assert.Assert

public let myPublicTopLet: String = """
    aqwf4sdg
    ${ 'F' }a
    dsg
      ${ (4 + 8)*10 - 6 }
"""
public var myPublicTopVar: String = "SDRH==R${ (6*5)/3 }"

let myTopLet: String = "${ "g" + "P" + "\u{1113}" }"
var myTopVar: String = """
\" ${ 5 < 6} """

func myFunc0(inVal1: Float32, inVal2: UInt8, inVal3: Bool) {
  """
    If("${inVal3}") Then use value ${inVal1} ${inVal2} times
  """
}
func myFunc1() {
  return """
    ${
  var flag = true 
  do { 
    flag = false 
  } while (flag) 
"1" 
    }
  """
}

main() {
  Assert.isTrue(myPublicTopLet == """
    aqwf4sdg
    Fa
    dsg
      114
""")
  Assert.isTrue(myPublicTopVar == "SDRH==R10")
  Assert.isTrue(myTopLet == "gPᄓ")
  Assert.isTrue(myTopVar == """
\" true """)
  Assert.isTrue(myFunc0(12.3, 8, true) == """
    If("true") Then use value 12.300000 8 times
  """)
  Assert.isTrue(myFunc1() == """
    1
  """)
}