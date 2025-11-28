/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_020

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that IntegerLiteral of type Int16 cannot be greater than maximal Int16 value.
                 (Int16: -32768 to 32767)

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main(){
    32768i16;
    return 0;
}

