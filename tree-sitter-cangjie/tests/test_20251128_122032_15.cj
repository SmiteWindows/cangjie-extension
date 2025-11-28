/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_167

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float64 to Float16 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float64 = -48760.0f64
var a2: Float64 = 22743.0f64

func foo(): Float64 { return -56425.0f64 }

class MyCls {
    static var m: Float64 = 14772.0f64
}

var r1 = Float16(a1)
let r2 = Float16(a2)

main(): Unit {
    let r3 = Float16(foo())
    var r4 = Float16(MyCls.m)

    Assert.isTrue(r1 is Float16)
    Assert.isTrue(r2 is Float16)
    Assert.isTrue(r3 is Float16)
    Assert.isTrue(r4 is Float16)

    Assert.approxEquals(-48760.0f16, r1)
    Assert.approxEquals(22743.0f16, r2)
    Assert.approxEquals(-56425.0f16, r3)
    Assert.approxEquals(14772.0f16, r4)
}
