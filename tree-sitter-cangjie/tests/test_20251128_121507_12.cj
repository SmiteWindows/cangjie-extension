/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_004

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Int8 to Int64 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Int8 = -37
var a2: Int8 = -87

func foo(): Int8 { return -102 }

class MyCls {
    static var m: Int8 = -22
}

var r1 = Int64(a1)
let r2 = Int64(a2)

main(): Unit {
    let r3 = Int64(foo())
    var r4 = Int64(MyCls.m)

    Assert.isTrue(r1 is Int64)
    Assert.isTrue(r2 is Int64)
    Assert.isTrue(r3 is Int64)
    Assert.isTrue(r4 is Int64)

    Assert.equals(-37, r1)
    Assert.equals(-87, r2)
    Assert.equals(-102, r3)
    Assert.equals(-22, r4)
}
