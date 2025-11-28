
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a33_01

  @Level:         1

  @Assertion:    2.3.1(33) Similarly, when there is precision loss, the round-to-nearest mode is applied for rounding. 

  @Description:  Check that if precision is lost, the round-to-nearest mode is applied for rounding.

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main(): Unit {
    Assert.equals(65530.0, Float16(65532_u16))
    Assert.equals(65532.0f16, 65530.0f16)

    Assert.equals(4294967290.0, Float32(4294967292_u32))
    Assert.equals(4294967292.0f32, 4294967290.0f32)

    Assert.equals(92233736854775600.0, Float64(92233736854775605_u64))
    Assert.equals(92233736854775605.0f64, 92233736854775600.0f64)
}