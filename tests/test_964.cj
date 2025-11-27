
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a34_01

  @Level:         1

  @Assertion:    2.3.1(34) The conversion from floating point to unsigned integer follows the round-toward-zero mode,
                 i.e. the fractional part is discarded. 

  @Description:  Check that the conversion from floating point to unsigned integer is performed in rounding mode 
                 to zero

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {
    Assert.equals(127, UInt8(127.7_f16))
    Assert.equals(0,   UInt8(0.68_f32))
    Assert.equals(254, UInt8(254.9_f64))

    Assert.equals(110,   UInt16(110.9_f16))
    Assert.equals(30767, UInt16(30767.999_f32))
    Assert.equals(3067,  UInt16(3067.599_f64))

    Assert.equals(7436,      UInt32(7436.005_f16))
    Assert.equals(74836,     UInt32(74836.45_f32))
    Assert.equals(429467295, UInt32(429467295.999_f64))

    Assert.equals(5,                 UInt64(5.93_f16))
    Assert.equals(9223775232,        UInt64(9223775232.4555_f32))
    Assert.equals(92233736854775600, UInt64(92233736854775600.5999_f64))

    Assert.equals(6324,              UIntNative(6324.599_f16))
    Assert.equals(6854775808,        UIntNative(6854775808.005_f32))
    Assert.equals(922337854775600,   UIntNative(922337854775600.4555_f64))
}