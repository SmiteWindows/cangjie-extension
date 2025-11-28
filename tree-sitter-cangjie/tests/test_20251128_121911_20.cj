/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        01_03_06_a01_001

  @Level:         1

  @Assertion:   1.3.6(1) The String literals in the Cangjie programming language can be divided into three categories: 
                    single-line string literals, multi-line string literals and multi-line raw string literals.

  @Description:  Checks that String literal cannot be represented as not single-line or not multi-line
                 or not multi-line raw string literals.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main(){
    let stringValue:String = incorrect_string_literal;
    return 0;
}

