/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a07_60

  @Level:         1

  @Assertion:    3.3.1(7)  let is used to define immutable variables.  Once initialized, a let variable 
                 cannot be changed.

  @Description:  Check that local-level variable defined as 'let' with specified variable type is immutable.
                 Case: reassign immutable variobale in cycle

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    let myLetUInt8NotInitialized: UInt8
    var myVarUInt8: UInt8 = 0 
    while (myVarUInt8 < 10) { 
        myLetUInt8NotInitialized = myVarUInt8
        myVarUInt8++ 
    } 
}