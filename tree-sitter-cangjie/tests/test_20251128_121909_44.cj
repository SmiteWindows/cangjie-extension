/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a01_03

  @Level:         1

  @Assertion:    2.1.2(1) The Cangjie programming language uses Rune to represent characters type.
   A value of type Rune is a Unicode code point. Characters can be classified into printable characters,
   non-printable characters (such as control characters), and special characters 
   (such as single quotation marks and backslashes).
 
  @Description:  Check that Rune type can contain printable characters, non-printable characters and special characters

  @Mode:         run

  @Negative:     no

  @Structure:    single
  
*/
import utils.assert.Assert

main() {
  var a: Rune
  var b: Rune
  var c: Rune

  a = r'a'
  b = r'\0'
  c = r'\''

  Assert.equals(r'a', a)
  Assert.equals(r'\0', b)
  Assert.equals(r'\'', c)
}