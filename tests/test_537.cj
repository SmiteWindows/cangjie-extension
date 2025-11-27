/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_042

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from Int64 to Int32 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Int64 = 71464390
var a2: Int64 = -964087462

func foo(): Int64 { return -479546764 }

class MyCls {
    static var m: Int64 = 1913950216
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

    Assert.equals(71464390, r1)
    Assert.equals(-964087462, r2)
    Assert.equals(-479546764, r3)
    Assert.equals(1913950216, r4)
}
