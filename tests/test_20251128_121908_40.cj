/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a01_05

  @Level:         1

  @Assertion:    1.2(1) There are two symbols that can indicate the end of an expression or declaration:
                        a semicolon (;) or a newline character.

  @Description:  Check when the newline character is not used between two pattern matching expressions.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    var score : Int64 = 20 ; res String = match (score) {case 20 => "pass" ; case _ => "not a valid score" ;
    }  res = match (score) {case 0 => "zero" ; case _ => "not a valid score" ; }}