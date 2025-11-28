/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a16_04

  @Level:         1

  @Assertion:    1.2(16) For multi-line raw string literal, the raw string literal is termintaed
                         by the first non-escaped double quotation and the same number of # characters
                         as the beginning.

  @Description:  Check when number of '#' for start and end for multi-line raw string literals differ.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let errorStr3 = ##"
1
2
3
"###########
}