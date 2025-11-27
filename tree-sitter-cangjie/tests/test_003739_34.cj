/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a03_01

  @Level:         1
  @Assertion:   12.1.1.1(3) Binary literals must start with 0b (or 0B), Octal literals must start with 0o (or 0O), And hexadecimal literals must start with 0x (or 0X).
  @Description: Check that binary, octal and hexadecimal literals give the correct value.
  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.Assert

main() {
  Assert.equals(1605, 0b110_0100_0101)
  Assert.equals(1606, 0B110_0100_0110)
  Assert.equals(2101, 0o4065)
  Assert.equals(2102, 0O4066)
  Assert.equals(2706, 0xa92)
  Assert.equals(2707, 0Xa93)
  return 0
}