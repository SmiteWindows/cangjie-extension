/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_137

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float16 to UInt16 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float16 = 33248.0f16
var a2: Float16 = 44096.0f16

func foo(): Float16 { return 43808.0f16 }

class MyCls {
    static var m: Float16 = 59392.4123f16
}

var r1 = UInt16(a1)
let r2 = UInt16(a2)

main(): Unit {
    let r3 = UInt16(foo())
    var r4 = UInt16(MyCls.m)

    Assert.isTrue(r1 is UInt16)
    Assert.isTrue(r2 is UInt16)
    Assert.isTrue(r3 is UInt16)
    Assert.isTrue(r4 is UInt16)

    Assert.equals(33248, r1)
    Assert.equals(44096, r2)
    Assert.equals(43808, r3)
    Assert.equals(59392, r4)
}
