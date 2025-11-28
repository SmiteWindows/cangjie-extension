/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a03_03

  @Level:         1
  @Assertion:   12.1.1.1(3) Binary literals must start with 0b (or 0B), Octal literals must start with 0o (or 0O), And hexadecimal literals must start with 0x (or 0X).
  @Description: Check that without prefix hexadecimal literals is not parsed as numeric literals.
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  let val = a92
  return 0
}