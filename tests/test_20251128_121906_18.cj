/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a02_12

  @Level:         1

  @Assertion:    1.2(2) Among them, the meaning of ; is fixed and indicates the end of an expression
                        or declaration regardless of where it appears, and multiple expressions
                        or declarations separated by ; can be written on the same line.

  @Description:  Check that variable declarations and initializers on the same line can be separated by ';'.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    var x : Int64 = 1 ; x = 0
    Assert.equals(0, x);
}
