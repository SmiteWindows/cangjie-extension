/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a07_02

  @Level:         1

  @Assertion:    3.3.1(7)  let is used to define immutable variables.  Once initialized, a let variable 
                 cannot be changed.

  @Description:  Check that top-level public variable defined as 'let' without specified variable type is immutable.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

public let testA0702 = "letString"
main() {
    testA0702 = "new letString"
}