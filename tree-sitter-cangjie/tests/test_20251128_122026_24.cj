/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a01_002

  @Level:         1

  @Assertion:   2.1.1(1) The numeric types are classified into integer types and floating-point
                types, which are used to represent integers and floating-point numbers,
                respectively.

  @Description: Checks that variable of interger type (e.g. Int16) cannot be assigned
                by floating-point value;

  @Mode:        compileonly 

  @Negative:    yes

  @Structure:   single

*/

main() {
    let integerVar: Int16 = 1.0;

    return 0
}