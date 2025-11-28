/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_02_a05_fpl_3

  @Level:         1

  @Assertion:    1.3.2(5) 
                 Meanwhile, a suffix can be added to denote the exact type of the floating point number

  @Description:  Check hex float number emit error if it has type suffix

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert
main() {
    // no type suffix for hex representation
    Assert.isTrue(0xA.BP-10f32 is Float32)
}
