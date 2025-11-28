/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a05_04

  @Level:         1

  @Assertion:    2.1.6.2(5) Line breaks are allowed in interpolation expressions inside multi-line strings.

  @Description:  Check that line breaks are not allowed in interpolation expressions inside single-line strings: inside function definition.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main() {
  var myComment = "Here is "
  let myCount = 10
  let mySingleLine: String = "${myComment
    myCount}"
}