/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_060

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined with FloatLiteralSuffix for type Float32, has expected Float value.
                 - immutable variable, assigned by literal with FloatLiteralSuffix for type Float32,
                   has expected Float value.
                 - mutable variable, assigned by literal with FloatLiteralSuffix for type Float32,
                   has expected Float value.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    Assert.approxEquals(127.0, 127.0f32, reason: "Test case 1 failed.");

    Assert.approxEquals(200.5, 200.5f32, reason: "Test case 2 failed.");

    let immutable_var = -200.5f32;
    Assert.approxEquals(-200.5, immutable_var, reason: "Test case 3 failed.");

    var mutable_var = 200.5f32;
    Assert.approxEquals(200.5, mutable_var, reason: "Test case 4 failed.");

    return 0;
}

