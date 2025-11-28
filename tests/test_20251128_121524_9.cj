/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a02_04

  @Level:         1

  @Assertion:    2.1.2(2) A Rune literal consisting of a pair of single quotes and the character itself.
 
  @Description:  Check that Rune literal cannot consist of a pair of braces

  @Mode:         compileonly 

  @Negative:     yes  

  @Structure:    single
 
*/

main() {
  var a: Rune
  a = {c}
}