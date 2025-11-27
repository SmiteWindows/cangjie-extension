/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_03_a04_06

  @Level:         1

   @Assertion:    2.1.3(4) The Cangjie programming language does not support implicit type conversion 
    between the numeric types and Bool.

   @Description:  Check that Cangjie doest not support type conversion between UInt8 and Bool

   @Mode:         compileonly

   @Negative:     yes

   @Structure:    single

   @Comment:

 */

main() {
  var b: Bool = true
  var num: UInt8 = 0

  num = UInt8(b)
  return 0
}