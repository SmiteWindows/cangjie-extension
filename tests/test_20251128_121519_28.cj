/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a02_03

  @Level:         1
  @Assertion:       2.1.8.1(2) It is required that the expression start and the expression end
                    have the same type and that step be of type Int64.  

  @Description:     Checks that range step cannot be of type other than Int64.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

main() {
  let a1 = 0i32..=10i32:2i32
  return 0
}
