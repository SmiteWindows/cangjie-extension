/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a03_01

  @Level:         1

  @Assertion:    2.1.2(3)
    'S'
    '5'
    ' ' // blank
 
  @Description:

  @Mode:         run 

  @Negative:     no  

  @Structure:    single
 
*/

import utils.assert.Assert

main() {
  var a: Rune
  var b: Rune
  var c: Rune

  a = r'S'
  b = r'5'
  c = r' '

  Assert.equals(r'S', a)
  Assert.equals(r'5', b)
  Assert.equals(r' ', c)
}