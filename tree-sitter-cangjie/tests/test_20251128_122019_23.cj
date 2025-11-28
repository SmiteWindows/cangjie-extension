/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_03_a01_03

  @Level:         1

  @Assertion:    1.3.3(1) A character literal consisting of a pair of single quotes and the character itself.

  @Description:  Emit error about character with wrong quotes

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/

main() {
    ''X''
    return 0
}

