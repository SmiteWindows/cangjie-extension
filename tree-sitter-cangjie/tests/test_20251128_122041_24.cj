/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_03_a06_01

  @Level:         1

   @Assertion:    2.1.3(6) The following operations are defined for Bool: assignment operation, 
    part of composite assignment operations (&&=, ||=), part of relational operations (==, !=),
    and all logical operations (!, &&, ||).

   @Description:  

   @Mode:         run

   @Negative:     no

   @Structure:    single

   @Comment:

 */

import utils.assert.Assert

 main() {
  var bool1: Bool
  var bool2: Bool 

  bool1 = true
  bool2 = false

  Assert.isTrue(!bool2)
  Assert.isTrue(bool1 == bool1)
  Assert.isTrue(bool1 != bool2)
  Assert.isTrue(bool1 || bool2)

  Assert.isFalse(!bool1)
  Assert.isFalse(bool1 == bool2)
  Assert.isFalse(bool1 != bool1)
  Assert.isFalse(bool1 && bool2)
 }

