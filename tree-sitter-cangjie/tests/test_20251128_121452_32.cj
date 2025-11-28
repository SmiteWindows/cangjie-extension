/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_01_a15_01

  @Level:         1

  @Assertion:    2.4.1(15) By default, the type definition is internally accessible.

  @Description:  Check that the alias is internally accessible, by default

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_file_01.cj

*/

package pkga

import utils.assert.Assert

main(): Unit {
    let a1: Float16 = 0.0
    let a2: AVeryLongAndUnintuitiveTypeName = 1.0

    Assert.isTrue(a1 is Float16)
    Assert.isTrue(a1 is AVeryLongAndUnintuitiveTypeName)
    
    Assert.isTrue(a2 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a2 is Float16)
}
