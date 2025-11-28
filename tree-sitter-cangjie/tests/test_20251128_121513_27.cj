/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_04_a01_02

  @Level:         1

   @Assertion:    2.1.4(1) The Unit type has only one value (). 

   @Description:  Check that Int value cannot be assigned to Unit type

   @Mode:         compileonly

   @Negative:     yes

   @Structure:    single

 */

main() {
  var u: Unit
  u = 2023
  return 0
}
