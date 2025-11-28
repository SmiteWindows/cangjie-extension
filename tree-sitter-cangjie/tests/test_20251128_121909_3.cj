/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         03_03_02_01_a01_02
  @Assertion:    3.3.2.1(1) There are two ways of initializing variables: initialization during declaration
                 and initialization after declaration.

  @Description:  Checks that mutable and immutable variables of various types
                 can be initialized after declaration

  @Mode:         run
  @Negative:     no
  @Structure:    single
  @Comment:

*/

import utils.assert.Assert

let CONST_FLOAT:Float64 = 1.2353546346e24

class Test {
    let instanceVar:Int32

    init() {
        instanceVar = 42
    }
}

main() {
    var unassignedF:Float16
    let unassigned:Int64

    let str:String
    let a:Int64
    var numE:Float64
    let trigger:Bool
    var optionalVar:Option<Test>
    var testVar:Test

    str = "ABC"
    a = 1
    numE = CONST_FLOAT
    trigger = true
    optionalVar = Option<Test>.None

    Assert.equals("ABC", str, reason:"String value must match")
    Assert.equals(1, a, reason:"Int value must match")
    Assert.equals(CONST_FLOAT, numE, reason:"Float64 value must match")
    Assert.isTrue(trigger, reason: "Boolean value should match")
    Assert.isNone(optionalVar, reason: "Instance wasn't created")

    testVar = Test()
    Assert.equals(42, testVar.instanceVar, reason:"Int value must match")
}
