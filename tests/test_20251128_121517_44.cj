/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_012

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined by Rune value, has type Rune.
                 - immutable variable, assigned by literal of type Rune, has type Rune.
                 - mutable variable, assigned by literal of type Rune, has type Rune.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    var isExpectedType:Bool = r'A' is Rune;
    Assert.equals(true, isExpectedType, 
        reason:"literal, defined by Rune value, has type different from Rune.");

    let immutable_var = r'B';
    isExpectedType = immutable_var is Rune;
    Assert.equals(true, isExpectedType, 
        reason:"immutable variable, assigned by literal of type Rune, has type different from Rune.");

    var mutable_var = r'C';
    isExpectedType = mutable_var is Rune;
    Assert.equals(true, isExpectedType, 
        reason:"mutable variable, assigned by literal of type Rune, has type different from Rune.");

    return 0;
}

