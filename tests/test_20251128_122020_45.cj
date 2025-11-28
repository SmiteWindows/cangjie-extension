/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_168

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float64 to Float32 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float64 = -1444633612.0f64
var a2: Float64 = -1578282326.0f64

func foo(): Float64 { return 1891961435.0f64 }

class MyCls {
    static var m: Float64 = -2073096624.0f64
}

var r1 = Float32(a1)
let r2 = Float32(a2)

main(): Unit {
    let r3 = Float32(foo())
    var r4 = Float32(MyCls.m)

    Assert.isTrue(r1 is Float32)
    Assert.isTrue(r2 is Float32)
    Assert.isTrue(r3 is Float32)
    Assert.isTrue(r4 is Float32)

    Assert.approxEquals(-1444633612.0f32, r1)
    Assert.approxEquals(-1578282326.0f32, r2)
    Assert.approxEquals(1891961435.0f32, r3)
    Assert.approxEquals(-2073096624.0f32, r4)
}
