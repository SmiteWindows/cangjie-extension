/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a09_04

  @Level:         1

  @Assertion:    3.3.1(9) let (or var) can can only be followed by patterns that must or may be irrefutable 
                 (see Classification of Patterns).

  @Description:  Check that variables can't be defined with refutable tuple pattern.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
  let (x, 13, z) = ("DSGDGS", true, 'K')
}