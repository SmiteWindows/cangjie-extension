/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_a02_013

  @Level:         1

  @Assertion:    1.3(2) Literals also have types. The types that have literals in Cangjie
                 include: integer types, floating point types, character type, boolean type
                 and string type.

  @Description:  Checks that:
                 - literal, defined by Bool value, has type Bool.
                 - immutable variable, assigned by literal of type Bool, has type Bool.
                 - mutable variable, assigned by literal of type Bool, has type Bool.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.*

main(){
    var isExpectedType:Bool = true is Bool;
    Assert.equals(true, isExpectedType, 
        reason:"literal, defined by Bool value 'true', has type different from Bool.");

    isExpectedType = false is Bool;
    Assert.equals(true, isExpectedType, 
        reason:"literal, defined by Bool value 'false', has type different from Bool.");

    let immutable_var = true;
    isExpectedType = immutable_var is Bool;
    Assert.equals(true, isExpectedType, 
        reason:"immutable variable, assigned by literal of type Bool, has type different from Bool.");

    var mutable_var = false;
    isExpectedType = mutable_var is Bool;
    Assert.equals(true, isExpectedType, 
        reason:"mutable variable, assigned by literal of type Bool, has type different from Bool.");

    return 0;
}

