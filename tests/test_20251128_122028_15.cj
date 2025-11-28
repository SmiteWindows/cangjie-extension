/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_001

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined with IntegerLiteralSuffix for type Int8, has type Int8.
                 - immutable variable, assigned by literal with IntegerLiteralSuffix for type Int8,
                   has type Int8.
                 - mutable variable, assigned by literal with IntegerLiteralSuffix for type Int8,
                   has type Int8.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    var isExpectedType:Bool = -111i8 is Int8;
    Assert.isTrue(isExpectedType, reason: "Test case 1 failed.");

    let immutable_var = -128i8;
    isExpectedType = immutable_var is Int8;
    Assert.isTrue(isExpectedType, reason: "Test case 2 failed.");

    var mutable_var = 127i8;
    isExpectedType = mutable_var is Int8;
    Assert.isTrue(isExpectedType, reason: "Test case 3 failed.");

    return 0;
}

