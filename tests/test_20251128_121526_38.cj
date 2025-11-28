/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_094

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt32 to Int32 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt32 = 1547682433
var a2: UInt32 = 1731698449

func foo(): UInt32 { return 1634756931 }

class MyCls {
    static var m: UInt32 = 249594179
}

var r1 = Int32(a1)
let r2 = Int32(a2)

main(): Unit {
    let r3 = Int32(foo())
    var r4 = Int32(MyCls.m)

    Assert.isTrue(r1 is Int32)
    Assert.isTrue(r2 is Int32)
    Assert.isTrue(r3 is Int32)
    Assert.isTrue(r4 is Int32)

    Assert.equals(1547682433, r1)
    Assert.equals(1731698449, r2)
    Assert.equals(1634756931, r3)
    Assert.equals(249594179, r4)
}
