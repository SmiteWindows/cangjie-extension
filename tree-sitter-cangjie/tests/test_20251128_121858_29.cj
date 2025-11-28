/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a08_02

  @Level:         1

  @Assertion:    3.3.1(8) var is used to define mutable variables.

  @Description:  Check that variable defined as 'var' is mutable.
                 Case: Value of local-level mutable variables can be changed

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    var myVarInt64Initialized: Int64 = 0
    var myVarNotDefinedInitialized = 0
    var myVarInt64NotInitialized: Int64

    Assert.equals(0, myVarInt64Initialized)
    myVarInt64Initialized = 22
    Assert.equals(22, myVarInt64Initialized)

    Assert.equals(0, myVarNotDefinedInitialized)
    myVarNotDefinedInitialized = -13
    Assert.equals(-13, myVarNotDefinedInitialized)

    myVarInt64NotInitialized = 45
    Assert.equals(45, myVarInt64NotInitialized)
    myVarInt64NotInitialized = -102
    Assert.equals(-102, myVarInt64NotInitialized)
}