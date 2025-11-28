/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a10_04

  @Level:         1
  @Assertion:   1.2(10) In the index access expression, a newline character cannot be used as a separator between [
                and the token preceding it.
  @Description: Checks that newline character cannot be used as a separator between [ and the token preceding it for
                Array<String>.
  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single
*/
main() {
    let arr = Array<String>(3) { i => "$i" }
    let elem = 1 + arr
    [2]
    return 0
}
