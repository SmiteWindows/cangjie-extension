/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a23_01

  @Level:         1

  @Assertion:    2.3.1(23) The following conversions may result in loss of precision and the result may be
                 POSITIVE_INFINITY or NEGTIVE_INFINITY: 
                    conversion from Int32 to Float16; 
                    conversion from Int64 to Float16.

  @Description:  Check that the listed conversions can lead to a loss of precision or may be infinity 

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {

    // from Int32 to Float16
    var i32_0: Int32 = -65538
    let i32_1: Int32 = 65536
    let i32_2: Int32 = 65535

    Assert.isTrue(Float16(i32_0).isInf())
    Assert.isTrue(Float16(i32_1).isInf())
    Assert.approxEquals(65535.0000,  Float16(i32_2 - 300))

    // from Int64 to Float16
    var i64_0: Int64 = -65538
    let i64_1: Int64 = 65538
    let i64_2: Int64 = 65535

    Assert.isTrue(Float16(i64_0).isInf())
    Assert.isTrue(Float16(i64_1).isInf())
    Assert.approxEquals(65535.0000,  Float16(i64_2 - 300))
}