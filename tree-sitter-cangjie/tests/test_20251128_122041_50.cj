/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_01_a12_02

  @Level:         1
  @Assertion:   2.1.1.1(12) In addition, the following are additional special floating-point literals:
                positive infinity (POSITIVE_INFINITY), negative infinity (NEGATIVE_INFINITY), 
                Not a Number (NaN), positive 0 (+0.0) and negative 0 (-0.0).
  @Description: Check positive 0 (+0.0)
  @Mode:        run
  @Negative:    no
  @Structure:   single
  @Issue:       6100
*/

import utils.assert.Assert

main() {
  var f16: Float16 = 0.0
  Assert.equals(Float16(0.0), f16)
  return 0
}