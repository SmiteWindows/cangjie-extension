/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a31_01

  @Level:         1

  @Assertion:    2.3.1(31) The following conversions may result in loss of precision: 
                    conversion from UInt32 to Float32;    
                    and conversion from UInt64 to Float32 and Float64.

  @Description:  Check that the listed conversions may result in loss of precision

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {

    // from UInt32 to Float32.
    let u32A: UInt32 = 4294967295
    let u32B: UInt32 = 2147483648

    Assert.approxEquals(4294967295.0000000000, Float32(u32A - 3), 0.0)
    Assert.approxEquals(2147483648.0000000000, Float32(u32B + 3), 0.0)

    // from UInt64 to Float32 and Float64
    let u64A: UInt64 = 18446744073709551615
    let u64B: UInt64 = 9223372036854775808

    Assert.approxEquals(18446744073709551615.0000000000, Float32(u64A - 3000), 0.0)
    Assert.approxEquals(9223372036854775808.0000000000,  Float32(u64B + 3000), 0.0)

    Assert.approxEquals(18446744073709551615.0000000000, Float64(u64A - 300), 0.0)
    Assert.approxEquals(9223372036854775808.0000000000,  Float64(u64B + 300), 0.0)
}