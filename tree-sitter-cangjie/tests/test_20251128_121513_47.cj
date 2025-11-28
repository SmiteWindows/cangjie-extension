/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a02_017

  @Level:         1

  @Assertion:    2(2) At the same time, it is a strongly typed language, 
                 i.e. every expression is associated with a type and the type of 
                 expression not only decides its possible values, but also decides that 
                 can be performed on them.

  @Description:  Checks that attempt to use division by zero in expression of type Int32 
                 results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    let operand_01: Int32 = 1;
    var operand_02 = 4i32;
    var expressionResult: Int32 = operand_01 * operand_02 / 0;
    return 0;
}

