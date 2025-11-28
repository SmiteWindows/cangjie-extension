/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a05_02

  @Level:         1

  @Assertion:    2.1.2(5)  Operations Defined for the Character Type
    Only relational operations are suppored for the Rune type(for which the comparison is based on Unicode code point).

  @Description:  Check that arithmetic operations are not suppored for Rune type

  @Mode:         compileonly

  @Negative:     yes  

  @Structure:    single
 
*/

main() {
  var a: Rune
  a = 'A'
  a = a + 1
  return 0
}