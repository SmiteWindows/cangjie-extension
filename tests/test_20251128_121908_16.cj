/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_01_a16_01

  @Level:         1

  @Assertion:    2.4.1(16) When using the the alias defined in this package in another package, the following two 
                 conditions must be met: (1) The accessibility of the original type is public,
                 and (2) The type definition is modified by public modifier.

  @Description:  Check that the alias is available from another package if all conditions are met.

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_file_01.cj

*/

import utils.assert.Assert
import aux_01.*

main(): Unit {
    let a1: SimpleType = -10.012
    let a2: AVeryLongAndUnintuitiveTypeName = 31.063

    Assert.isTrue(a1 is Float16)
    Assert.isTrue(a1 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a1 is SimpleType)
    
    Assert.isTrue(a2 is AVeryLongAndUnintuitiveTypeName)
    Assert.isTrue(a2 is SimpleType)
    Assert.isTrue(a2 is Float16)
}
