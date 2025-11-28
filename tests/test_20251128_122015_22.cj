/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_02_a10_05

  @Level:         1
  @Assertion:   1.2(10) In the index access expression, a newline character cannot be used as a separator between [
                and the token preceding it.
  @Description: Checks that newline character cannot be used as a separator between [ and token preceding it in 
                two-dimensional array.
  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single
*/
main() {
    let arr = [[0.1, 0.2], [0.3, 0.4]]
    let elem = 1 + arr
    [0]
    [1]
    
    return 0
}
