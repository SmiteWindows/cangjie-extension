/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a05_fpl_1

  @Level:         1

  @Assertion:    1.3.2(5) 
                 Meanwhile, a suffix can be added to denote the exact type of the floating point number

  @Description:  Check float numbers with type suffix has needed type

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert
main() {
    Assert.isTrue(2.002e4f32 is Float32) 
    Assert.isTrue(2.003E4f16 is Float16) 
    Assert.isTrue(2.004e4f64 is Float64) 
    // no type suffix for hex representation
    Assert.isTrue(0x.1p1 is Float64)
    Assert.isTrue(0xA.BP-10 is Float64)
}
