/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_030

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that IntegerLiteral of type UInt64 cannot be greater than maximal UInt64 value.
                 (UInt64: 0 to 18446744073709551615)

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main(){
    18446744073709551616u64;
    return 0;
}

