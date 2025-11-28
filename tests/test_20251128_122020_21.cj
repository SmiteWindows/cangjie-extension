
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a04_44

  @Level:         1
  @Assertion:   12.1.1.1(4) Decimal literals do not require a prefix.
  @Description: Checks that '0Y' can't be used as decimal prefix
  @Comment:     Auto-generated test by gen_tests.py
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  let value = 0Y12345
  return 0
}
