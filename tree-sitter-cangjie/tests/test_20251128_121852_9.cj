/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a11_03

  @Level:         1

  @Assertion:    2.1.6.2(11) The types described above all implement the ToString interface.

  @Description:  Check that tuple type not implement the ToString interface.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
main() {
  var myToStringVar: ToString = ("segsd", true, 'S')
}