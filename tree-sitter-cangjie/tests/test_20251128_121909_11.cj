/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_164

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Float64 to UInt32 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Float64 = 2454983881.0f64
var a2: Float64 = 1298441174.0f64

func foo(): Float64 { return 3611408846.0f64 }

class MyCls {
    static var m: Float64 = 1665574037.0f64
}

var r1 = UInt32(a1)
let r2 = UInt32(a2)

main(): Unit {
    let r3 = UInt32(foo())
    var r4 = UInt32(MyCls.m)

    Assert.isTrue(r1 is UInt32)
    Assert.isTrue(r2 is UInt32)
    Assert.isTrue(r3 is UInt32)
    Assert.isTrue(r4 is UInt32)

    Assert.equals(2454983881, r1)
    Assert.equals(1298441174, r2)
    Assert.equals(3611408846, r3)
    Assert.equals(1665574037, r4)
}
