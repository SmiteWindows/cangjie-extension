/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
   @Name:         02_01_03_a05_01

  @Level:         1

   @Assertion:    2.1.3(5) Only either true and false can be used where a Boolean value is expected.
    Otherwise, a compilation error is reported.

   @Description:  Check that only either true and false can be used where a Boolean value is expected

   @Mode:         run

   @Negative:     no

   @Structure:    single

   @Comment:

 */

import utils.assert.Assert

main() {
  var b: Bool
  b = true
  Assert.isTrue(b)
  b = false
  Assert.isFalse(b)
  return 0
}
