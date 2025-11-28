/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a02_01

  @Level:         1

  @Assertion:    2.3.1(2) Type conversion from integer types (i.e., Int8, Int16, Int32, Int64, IntNative,
                 UInt8, UInt16, UInt32, UInt64 and UIntNative) to Rune.

  @Description:  Check that the type conversion from Int8 to Rune is supported

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a1: Int8 = 77
var a2: Int8 = 45

func foo(): Int8 { return 74 }

class MyCls {
    static var m: Int8 = 5
}

var r1 = Rune(a1)
let r2 = Rune(a2)

main(): Unit {
    let r3 = Rune(foo())
    var r4 = Rune(MyCls.m)

    Assert.isTrue(r1 is Rune)
    Assert.isTrue(r2 is Rune)
    Assert.isTrue(r3 is Rune)
    Assert.isTrue(r4 is Rune)

    Assert.equals(77, UInt32(r1))
    Assert.equals(45, UInt32(r2))
    Assert.equals(74, UInt32(r3))
    Assert.equals(5, UInt32(r4))
}
