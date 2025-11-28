/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a14_04

  @Level:         1

  @Assertion:    1.2(14) For single line string literal, the string literal is terminated
                         by the first non-escaped double quotation (");

  @Description:  No first non-escape double quotation for Uni Character Literals.

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

*/

main() {
    let s  : String = "\u{4f60}\u{101}\u{ffff}abc"
}
