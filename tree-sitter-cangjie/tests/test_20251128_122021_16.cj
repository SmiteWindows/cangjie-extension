/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_a01_03

  @Level:         1

  @Assertion:    2.1.6(1) The string type is written as String, and useful for holding textual data. A string consists a series of Unicode characters.

  @Description:  Check that variable declared as String can't hold boolean data.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
let myTopLet: String = false

main() {
}