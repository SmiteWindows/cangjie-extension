/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_070

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt8 to IntNative is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt8 = 158
var a2: UInt8 = 4

func foo(): UInt8 { return 116 }

class MyCls {
    static var m: UInt8 = 158
}

var r1 = IntNative(a1)
let r2 = IntNative(a2)

main(): Unit {
    let r3 = IntNative(foo())
    var r4 = IntNative(MyCls.m)

    Assert.isTrue(r1 is IntNative)
    Assert.isTrue(r2 is IntNative)
    Assert.isTrue(r3 is IntNative)
    Assert.isTrue(r4 is IntNative)

    Assert.equals(158, r1)
    Assert.equals(4, r2)
    Assert.equals(116, r3)
    Assert.equals(158, r4)
}
