/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:          bug_0005869_bil_i16

  @Assertion:   Bug 0005869: 
                Compiler emits exceed error for '0b1010_1010_i8':
                error: the number '0b1010_1010_i8' exceeds the value range of 
                type 'Int8'. 
                However, we see number fits in 8 bits.
                The same issues for other types: Int16, Int32, Int64.

                Rejected by Huawei on 06.04:
                The literal value is not automatically converted to a negative 
                number. It is processed as a positive number, which is beyond 
                the expression range of int8.
                 
  @Description: Checks that literals for negative Int16 numbers in the binary 
                representation (0b) gets rejected by the compiler.

  @Mode:         Compileonly

  @Negative:     Yes

  @Structure:    Single
*/

main():Int16 {
  0b1010_1010_1010_1010_i16
}
