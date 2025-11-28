/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a01_04

  @Level:         1

  @Assertion:    1.2(1) There are two symbols that can indicate the end of an expression or declaration:
                        a semicolon (;) or a newline character.

  @Description:  Check if the newline character is not used as separator for the conditional expression
                 and variable declaration.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let x = 100
    if (x > 0) {print("x is larger than 0")} else {print("x is not larger than 0")} let y = 200
}
