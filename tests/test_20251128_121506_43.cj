/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_061

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from IntNative to UInt64 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: IntNative = 1173495286137202749
var a2: IntNative = 5698842578752886940

func foo(): IntNative { return 1954730919290508964 }

class MyCls {
    static var m: IntNative = 1700747878526852786
}

var r1 = UInt64(a1)
let r2 = UInt64(a2)

main(): Unit {
    let r3 = UInt64(foo())
    var r4 = UInt64(MyCls.m)

    Assert.isTrue(r1 is UInt64)
    Assert.isTrue(r2 is UInt64)
    Assert.isTrue(r3 is UInt64)
    Assert.isTrue(r4 is UInt64)

    Assert.equals(1173495286137202749, r1)
    Assert.equals(5698842578752886940, r2)
    Assert.equals(1954730919290508964, r3)
    Assert.equals(1700747878526852786, r4)
}
