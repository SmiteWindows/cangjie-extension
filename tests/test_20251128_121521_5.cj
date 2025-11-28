/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a01_06

  @Level:         1

  @Assertion:    3.3.2.2(1) Variables defined at the top-level are called global variables.

  @Description:  Check that non-global variable is not visible in another function.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    complex-main

  @Dependencies: aux_test_a01_06.cj

*/

main() {
    gInt == 0
    return 0
}
