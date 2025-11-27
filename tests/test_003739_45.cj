/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a02_008

  @Level:         1

  @Assertion:    2(2) At the same time, it is a strongly typed language, 
                 i.e. every expression is associated with a type and the type of 
                 expression not only decides its possible values, but also decides that 
                 can be performed on them.

  @Description:  Checks that attempt to assign a expression, calculating a value of type Bool,
                 to a variable of type Tuple results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    let operand_01: String = "S1";
    var operand_02 = "S2";
    var expressionResult: (Bool, Bool) = operand_01 == operand_02;
    return 0;
}


