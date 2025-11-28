/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_011

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined with FloatLiteralSuffix for type Float64, has type Float64.
                 - immutable variable, assigned by literal with FloatLiteralSuffix for type Float64,
                   has type Float64.
                 - mutable variable, assigned by literal with FloatLiteralSuffix for type Float64,
                   has type Float64.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    var isExpectedType:Bool = 1000.5f64 is Float64;
    Assert.isTrue(isExpectedType, reason: "Test case 1 failed.");

    let immutable_var = 2000.5f64;
    isExpectedType = immutable_var is Float64;
    Assert.isTrue(isExpectedType, reason: "Test case 2 failed.");

    var mutable_var = 3000.5f64;
    isExpectedType = mutable_var is Float64;
    Assert.isTrue(isExpectedType, reason: "Test case 3 failed.");

    return 0;
}

