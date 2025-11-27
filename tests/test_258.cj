/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a03_113

  @Level:         1

  @Assertion:    2.3.1(3) Type conversion between all numeric types (including Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64, UIntNative, Float16, Float32 and Float64).

  @Description:  Check that the type conversion from UInt64 to UInt64 is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: UInt64 = 3761267720375983231
var a2: UInt64 = 6565764300556831377

func foo(): UInt64 { return 8276283424222272210 }

class MyCls {
    static var m: UInt64 = 7031291955105579037
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

    Assert.equals(3761267720375983231, r1)
    Assert.equals(6565764300556831377, r2)
    Assert.equals(8276283424222272210, r3)
    Assert.equals(7031291955105579037, r4)
}
