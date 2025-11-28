/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_089

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt16 to Float16 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt16 = 62391
var a2: UInt16 = 47309

func foo(): UInt16 { return 20391 }

class MyCls {
    static var m: UInt16 = 44723
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

    Assert.approxEquals(62391.0f16, r1)
    Assert.approxEquals(47309.0f16, r2)
    Assert.approxEquals(20391.0f16, r3)
    Assert.approxEquals(44723.0f16, r4)
}
