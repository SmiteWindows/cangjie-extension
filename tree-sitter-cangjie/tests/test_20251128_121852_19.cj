/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_107

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt64 to Int32 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt64 = 89560705
var a2: UInt64 = 1484857729

func foo(): UInt64 { return 65887810 }

class MyCls {
    static var m: UInt64 = 192418748
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

    Assert.equals(89560705, r1)
    Assert.equals(1484857729, r2)
    Assert.equals(65887810, r3)
    Assert.equals(192418748, r4)
}
