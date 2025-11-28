/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a01_05

  @Level:         1
  @Assertion:   2.1.1.1(1) Terms such as 5, 24, 2.9, and 3.14 are referred to as numeric literals.
                Literals can be referred to only by their values and their values cannot be changed.
  @Description: Try to set the same value of floating point numeric literal to itself.
  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

main() {
  12.3 = 12.3
  return 0
}