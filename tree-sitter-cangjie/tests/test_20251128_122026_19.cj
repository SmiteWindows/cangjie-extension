/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a14_11

  @Level:         1

  @Assertion:    3.3.1(14) If the variable type is not declared, you need to assign an initial value to the variable.

  @Description:  Check that immutable variables declared w\o type must be initialised.
                 Case: immutable struct member variable

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

struct MyTestStruct { 
    let myVar
} 

main() {
}