/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_041

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Int64 to Int16 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Int64 = 17088
var a2: Int64 = -15056

func foo(): Int64 { return -11151 }

class MyCls {
    static var m: Int64 = 10506
}

var r1 = Int16(a1)
let r2 = Int16(a2)

main(): Unit {
    let r3 = Int16(foo())
    var r4 = Int16(MyCls.m)

    Assert.isTrue(r1 is Int16)
    Assert.isTrue(r2 is Int16)
    Assert.isTrue(r3 is Int16)
    Assert.isTrue(r4 is Int16)

    Assert.equals(17088, r1)
    Assert.equals(-15056, r2)
    Assert.equals(-11151, r3)
    Assert.equals(10506, r4)
}
