/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a04_01

  @Level:         1

  @Assertion:   2.1.2 (4) Non-printable and special character literals are written escape sequences (\).
    (@FIXME: Non-printable and special character literals are written as escape sequences (\).)
    escape character | character
    \0   | Empty character
    \\   | backslash \
    \b   | Backspace  
    \f   | Writer
    \n   | newline
    \r   | Enter
    \t   | Horizontal tab
    \v   | Vertical tab
    \’   | single quotation mark ’
    \”   | double quotation marks ”
    \u{X}   | Any Unicode code point, where X is a 1-8 digit hexadecimal number

 
  @Description:  Check that Rune type can contain non-printable and special characters

  @Mode:         run 

  @Negative:     no  

  @Structure:    single
 
*/
import utils.assert.Assert

main() {
  let speChar = [r'\0', r'\\', r'\b', r'\f', r'\n', r'\r', r'\r', r'\t', r'\v', r'\'', r'\"', r'\u{ffff}']
  for (char in speChar) {
    var a: Rune
    a = char
    Assert.equals(char, a)
  }
}