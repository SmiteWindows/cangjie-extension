/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_03_a02_1

  @Level:         1

  @Assertion:    1.3.3(2) The syntax is:

  @Description:  Check correct syntax variations for character literal

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert

main() {
    Assert.equals(r'A', r'A')
    Assert.equals(r'a', r'a') 
    Assert.equals(r'0', r'0') 
    // EscapedIdentifier
    Assert.isTrue(r'\t' > r'\0') 
    Assert.isTrue(r'\b' > r'\0') 
    Assert.isTrue(r'\r' > r'\0') 
    Assert.isTrue(r'\n' > r'\0') 
    Assert.isTrue(r'\t' > r'\0') 
    Assert.isTrue(r'\\' > r'\0') 
    Assert.isTrue(r'\'' > r'\0') 
    Assert.isTrue(r'\f' > r'\0') 
    Assert.isTrue(r'\v' > r'\0') 
    Assert.isTrue(r'\$' > r'\0') 

    Assert.isTrue(r'\u{1}'       is Rune)
    Assert.isTrue(r'\u{12}'      is Rune)
    Assert.isTrue(r'\u{123}'     is Rune)
    Assert.isTrue(r'\u{1234}'    is Rune)
    Assert.isTrue(r'\u{2345}'    is Rune)
    Assert.isTrue(r'\u{3456}'    is Rune)
    Assert.isTrue(r'\u{4567}'    is Rune)
    Assert.isTrue(r'\u{5678}'    is Rune)
    Assert.isTrue(r'\u{7fff}'    is Rune)
    Assert.isTrue(r'\u{00ff}'    is Rune)
    return 0
}

