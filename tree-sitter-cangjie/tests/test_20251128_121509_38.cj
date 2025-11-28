/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a18_19

  @Level:         1

  @Assertion:    3.3.1(18) The keyword let/varand the pattern are mandatory.

  @Issue:        6526

  @Description:  Check that top-level immutable variable can't be defined w/o name pattern

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

let = 126

main() {
}