/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a01_07

  @Level:         1

  @Assertion:    2.1.2(1) The Cangjie programming language uses Rune to represent characters type.
   A value of type Rune is a Unicode code point. Characters can be classified into printable characters,
   non-printable characters (such as control characters), and special characters 
   (such as single quotation marks and backslashes).
 
  @Description:  Check that Rune type can contain upper case Russian alphabet

  @Mode:         run

  @Negative:     no

  @Structure:    single
  
*/

import utils.assert.Assert

main() {
  let alphabet = [ r'А', r'Б', r'В', r'Г', r'Д', r'Е', r'Ё', r'Ж', r'З', r'И', r'Й', r'К', r'Л', r'М',
    r'Н', r'О', r'П', r'Р', r'С', r'Т', r'У', r'Ф', r'Х', r'Ц', r'Ч', r'Ш', r'Щ', r'Ъ',
    r'Ы', r'Ь', r'Э', r'Ю', r'Я']
  for (char in alphabet) {
    var a: Rune
    a = char
    Assert.equals(char, a)
  }
}