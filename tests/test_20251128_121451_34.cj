/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a26_02

  @Level:         1

  @Assertion:    3.2.3.2(26) For exception handling expressions, the try block, each catch block and 
                             the finally block are considered different blocks.
                             As a result, variable defined in the try block or catch blocks are not accessible 
                             in the finally block.

  @Description:  Checks that the variables inroduced in the catch block is not accessible in the finaly block.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    try {
    } catch (_) {
        let catchBlockVar = 2
    } finally {
        print(catchBlockVar) 
    }
}
