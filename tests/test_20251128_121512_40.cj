/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a06_02

  @Level:         1
  @Assertion:       2.1.8.1(6) In the expression start..end:step and start..=end:step, the value
                    of step must not be 0.

  @Description:     Checks that step must not be 0 in the expression start..=end:step.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

*/

main() {
  let range = -3..=12:0
  return 0
}
