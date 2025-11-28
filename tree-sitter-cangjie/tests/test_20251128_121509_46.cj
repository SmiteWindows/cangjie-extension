/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a01_06

  @Level:         1

  @Assertion:    2.1.2(1) The Cangjie programming language uses Rune to represent characters type.
   A value of type Rune is a Unicode code point. Characters can be classified into printable characters,
   non-printable characters (such as control characters), and special characters 
   (such as single quotation marks and backslashes).
 
  @Description:  Check that Rune type can contain lower case Russian alphabet

  @Mode:         run

  @Negative:     no

  @Structure:    single
  
*/

import utils.assert.Assert

main() {
  let alphabet = [r'а', r'б', r'в', r'г', r'д', r'е', r'ё', r'ж', r'з', r'и', r'й', r'к', r'л', r'м', r'н', r'о', 
    r'п', r'р', r'с', r'т', r'у', r'ф', r'х', r'ц', r'ч', r'ш', r'щ', r'ъ', r'ы', r'ь', r'э', r'ю', r'я']
  for (char in alphabet) {
    var a: Rune
    a = char
    Assert.equals(char, a)
  }
}