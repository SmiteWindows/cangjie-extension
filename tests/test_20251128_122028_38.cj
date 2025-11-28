/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_162

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float64 to UInt8 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float64 = 46.0f64
var a2: Float64 = 234.0f64

func foo(): Float64 { return 110.0f64 }

class MyCls {
    static var m: Float64 = 141.0f64
}

var r1 = UInt8(a1)
let r2 = UInt8(a2)

main(): Unit {
    let r3 = UInt8(foo())
    var r4 = UInt8(MyCls.m)

    Assert.isTrue(r1 is UInt8)
    Assert.isTrue(r2 is UInt8)
    Assert.isTrue(r3 is UInt8)
    Assert.isTrue(r4 is UInt8)

    Assert.equals(46, r1)
    Assert.equals(234, r2)
    Assert.equals(110, r3)
    Assert.equals(141, r4)
}
