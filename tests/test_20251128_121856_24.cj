/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a08_05

  @Level:         1

  @Assertion:    1.2(8) Scenarios where the use of a newline character as a separator
                        between two tokens is prohibited are listed as follows:
			- A newline character cannot be used as a separator
                        between a unary operator and its operand.

  @Description:  newline character cannot be used as a separator between a '--' unary operator and its operands.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    var u8 : UInt8  = 8
    
    i8
    --
}
