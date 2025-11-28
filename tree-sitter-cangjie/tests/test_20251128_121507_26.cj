/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_014

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined by String value, has type String.
                 - immutable variable, assigned by literal of type String, has type String.
                 - mutable variable, assigned by literal of type String, has type String.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    var isExpectedType:Bool = "String_01" is String;
    Assert.equals(true, isExpectedType, 
        reason:"literal, defined by String value, has type different String.");

    let immutable_var = "String_02";
    isExpectedType = immutable_var is String;
    Assert.equals(true, isExpectedType, 
        reason:"immutable variable, assigned by literal of type String, has type different String.");

    var mutable_var = "String_03";
    isExpectedType = mutable_var is String;
    Assert.equals(true, isExpectedType, 
        reason:"mutable variable, assigned by literal of type String, has type different String.");

    return 0;
}

