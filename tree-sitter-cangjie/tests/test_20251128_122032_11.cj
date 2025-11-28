/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_03_a01_01

  @Level:         1

  @Assertion:   2.3(1) For value types, using valueType(expr) to convert the type of expr to the valueType type.

  @Description:  Check that can use the valueType(expr) syntax to convert 

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

let a0 = Float16(67)
let a1 = Float32(-85467.43567_f16)
let a2 = Rune(565_i16)
let a3 = IntNative(-124.68_f32)
let a4 = UIntNative(122_i8)

main(): Unit {
    Assert.isTrue(a0 is Float16)
    Assert.isTrue(a1 is Float32)
    Assert.isTrue(a2 is Rune)
    Assert.isTrue(a3 is IntNative)
    Assert.isTrue(a4 is UIntNative)
}
