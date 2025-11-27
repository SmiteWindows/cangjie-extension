/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_03_a02_05

  @Level:         1

   @Assertion:    2.1.3(2) There are only two Bool literals: true and false.

   @Description:  Check that Bool type cannot have values other than true or false

   @Mode:         compileonly

   @Negative:     yes

   @Structure:    single

   @Comment:

 */

main() {
  var b: Bool
  b = 'c'
  return 0
}
