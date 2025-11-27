/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:          02_01_06_01_a07_02

  @Level:         1

  @Assertion:     2.1.6.1(7) Different from single-line string literals, a multi-line string literal
                  must span multiple lines.

  @Description:   Check that single-line string can't be typed in 2 and more lines.

  @Mode:          compileonly

  @Negative:      yes

  @Structure:     single

*/

let mySingleLine: String = "AB
C"
main() {
}