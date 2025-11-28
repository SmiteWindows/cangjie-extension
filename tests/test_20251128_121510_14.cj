/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a01_fpl_4_neg

  @Level:         1

  @Assertion:    1.3.2(1) 
                 Floating-point literals can be written in 2 bases:
                 decimal (without prefix) and hexadecimal (prefixed with 0xor 0X).

  @Description:  Check incorrect hex exponent

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/
main() {
    0xA.4e-1
    0
}
