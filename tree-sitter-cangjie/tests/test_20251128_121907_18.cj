/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a01_05

  @Level:         1

  @Assertion:    2.1.2(1) The Cangjie programming language uses Rune to represent characters type.
   A value of type Rune is a Unicode code point. Characters can be classified into printable characters,
   non-printable characters (such as control characters), and special characters 
   (such as single quotation marks and backslashes).
 
  @Description:  Check that Rune type can contain upper case English alphabet

  @Mode:         run

  @Negative:     no

  @Structure:    single
  
*/

import utils.assert.Assert

main() {
  let alphabet = [r'A', r'B', r'C', r'D', r'E', r'F', r'G', r'H', r'I', r'J', r'K', r'L', r'M', r'N', r'O', r'P', r'Q', 
    r'R', r'S', r'T', r'W', r'X', r'Y', r'Z']
  for (char in alphabet) {
    var a: Rune
    a = char
    Assert.equals(char, a)
  }
}