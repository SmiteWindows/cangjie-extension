/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a13_05

  @Level:         1

  @Assertion:    2.1.6.1(13) String type support using == (!=) for equality (inequality) comparison. We say two strings are equal, if and only if their corresponding code point sequences are identical.

  @Description:  Unusable comparison operator >

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

  @Comment:      

  @Issue: 0006092

*/
main() {
  var myVar = "opweifhse"
  let myVarCopy = myVar + "2"
  var compareResult = (myVarCopy > myVar)
}