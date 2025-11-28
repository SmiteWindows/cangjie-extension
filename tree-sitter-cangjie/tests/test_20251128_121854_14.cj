/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_039

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Int32 to Float64 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Int32 = -874622620
var a2: Int32 = 506636461

func foo(): Int32 { return 579489732 }

class MyCls {
    static var m: Int32 = 1426022452
}

var r1 = Float64(a1)
let r2 = Float64(a2)

main(): Unit {
    let r3 = Float64(foo())
    var r4 = Float64(MyCls.m)

    Assert.isTrue(r1 is Float64)
    Assert.isTrue(r2 is Float64)
    Assert.isTrue(r3 is Float64)
    Assert.isTrue(r4 is Float64)

    Assert.approxEquals(-874622620.0f64, r1)
    Assert.approxEquals(506636461.0f64, r2)
    Assert.approxEquals(579489732.0f64, r3)
    Assert.approxEquals(1426022452.0f64, r4)
}
