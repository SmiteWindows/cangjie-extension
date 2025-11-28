/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a22_01

  @Level:         1

  @Assertion:    2.3.1(22) The following conversions may result in loss of precision: 
                    conversion from Int16 to Float16;
                    conversion from Int32 to Float32; 
                    and conversion from Int64 to Float32 or Float64.

  @Description:  Check that the listed conversions can lead to a loss of precision

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {
    // from Int16 to Float16
    var i16_0: Int16 = -32768
    let i16_1: Int16 = 32767

    Assert.approxEquals(-32768.0000, Float16(i16_0 + 300))
    Assert.approxEquals(32767.0000,  Float16(i16_1 - 300))

    // from Int32 to Float32
    var i32_0: Int32 = -2147483648
    let i32_1: Int32 = 2147483647

    Assert.approxEquals(-2147483648.0000000, Float32(i32_0 + 300000))
    Assert.approxEquals(2147483647.0000000,  Float32(i32_1 - 300000))

    // from Int64 to Float32 or Float64
    var i64_0: Int64 = -9223372036854775808
    let i64_1: Int64 = 9223372036854775767

    Assert.approxEquals(-9223372036854775808.0000000, Float32(i64_0 + 3000000000000000))
    Assert.approxEquals(9223372036854775767.0000000,  Float32(i64_1 - 3000000000000000))

    Assert.approxEquals(-9223372036854775808.0000000000, Float64(i64_0 + 300000000000000))
    Assert.approxEquals(9223372036854775807.0000000000,  Float64(i64_1 - 300000000000000))
}