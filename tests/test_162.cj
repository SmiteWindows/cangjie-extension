/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_105

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt64 to Int8 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt64 = 46
var a2: UInt64 = 7

func foo(): UInt64 { return 30 }

class MyCls {
    static var m: UInt64 = 121
}

var r1 = Int8(a1)
let r2 = Int8(a2)

main(): Unit {
    let r3 = Int8(foo())
    var r4 = Int8(MyCls.m)

    Assert.isTrue(r1 is Int8)
    Assert.isTrue(r2 is Int8)
    Assert.isTrue(r3 is Int8)
    Assert.isTrue(r4 is Int8)

    Assert.equals(46, r1)
    Assert.equals(7, r2)
    Assert.equals(30, r3)
    Assert.equals(121, r4)
}
