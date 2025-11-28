/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_021

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that IntegerLiteral of type UInt16 cannot be less than minimal UInt16 value.
                 (UInt16: 0 to 65535)

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main(){
    -1u16;
    return 0;
}

