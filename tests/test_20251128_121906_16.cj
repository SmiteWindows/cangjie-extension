/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a17_32

  @Level:         1

  @Assertion:    3.3.1(17) When the variable type is specified, a colon ( :) must be used between the pattern and the
                 type. Otherwise, the type is inferred by the compiler.

  @Description:  Check that missed ":" before variable type for immutable struct member variable will produce error 
                 on compilation

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

struct Triangle { 
    let myLet String = "10" 
}

main() {
}