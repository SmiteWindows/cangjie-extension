/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a23_02

  @Level:         1

  @Assertion:    3.2.3.2(23) And it is additionally specified that the loop condition cannot refer 
                 to a variable defined in the loop body.

  @Description:  Checks that the loop condition variable cannot refer to same variable defined in the while block.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    while (num > 0) {
        let num = 0
    }
}