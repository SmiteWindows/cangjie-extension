/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a10_05

  @Level:         1
  @Assertion:    3.2.4(10) The following example illustrate shadowing on variables in different scenarios.

  @Mode:         compileonly
  @Negative:     yes

*/

enum Maze {
    C1 | C2
       | C1 // Error. The C1 has been used
}

main() {
}
