/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a02_015

  @Level:         1

  @Assertion:    2(2) At the same time, it is a strongly typed language, 
                 i.e. every expression is associated with a type and the type of 
                 expression not only decides its possible values, but also decides that 
                 can be performed on them.

  @Description:  Checks that attempt to use in expression of type Rune,
                 operator '-' (Subtract) results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    let operand_01: Rune = '1';
    var operand_02 = '2';
    var expressionResult: Rune = operand_01 - operand_02;
    return 0;
}

