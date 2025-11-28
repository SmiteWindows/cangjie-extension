/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a25_01

  @Level:         1

  @Assertion:    3.2.3.2(25) For while and do-while expressions, neither of their loop conditions 
                             can refer to the variable names introduced in their loop bodies,
                             even if the loop condition for do-while comes later then the loop body.

  @Description:  Checks that the loop condition for the while expression cannot refer to the variable 
                 introduced in the loop body.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    while (num > 0) {
        var num = 0
    }
}
