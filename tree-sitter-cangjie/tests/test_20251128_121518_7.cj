/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a03_008

  @Level:         1

  @Assertion:    2(3) Static typing and strong typing facilitate programmers to discover 
                 program errors at compile time.

  @Description:  Checks that attempt to use in expression of type Int32 the value less than
                 minimal value of Int32 (-2147483648) results in a compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:  

*/

main() {
    let operand_01: Int32 = 20;
    var operand_02 = 10i32;
    var expressionResult: Int8 = operand_01 + operand_02 + -2147483649i32;
    return 0;
}

