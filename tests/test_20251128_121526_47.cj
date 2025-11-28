/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_166

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float64 to UIntNative is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float64 = 6532851684376886272.0f64
var a2: Float64 = 2239557621791313920.0f64

func foo(): Float64 { return 9195188346895509504.0f64 }

class MyCls {
    static var m: Float64 = 8052720450677974016.0f64
}

var r1 = UIntNative(a1)
let r2 = UIntNative(a2)

main(): Unit {
    let r3 = UIntNative(foo())
    var r4 = UIntNative(MyCls.m)

    Assert.isTrue(r1 is UIntNative)
    Assert.isTrue(r2 is UIntNative)
    Assert.isTrue(r3 is UIntNative)
    Assert.isTrue(r4 is UIntNative)

    Assert.equals(6532851684376886272, r1)
    Assert.equals(2239557621791313920, r2)
    Assert.equals(9195188346895509504, r3)
    Assert.equals(8052720450677974016, r4)
}
