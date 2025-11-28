/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_032

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that literal, defined with IntegerLiteralSuffix for type UInt8, 
                 could not be assigned to immutable variable of Int8.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main(){
    let immutable_var:Int8 = 127u8;
    return 0;
}

