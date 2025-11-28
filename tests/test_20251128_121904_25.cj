/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a03_02

  @Level:         1

  @Assertion:    3.3.2.2(3) All global/static variables are initialized before the execution of the main (the entry
                 point);

  @Description:  Check that global variables (defined in another file) are initialized before main

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_test_a03_02.cj ../../init_order/init_common.cj 

  @Issue:        0006065

*/

internal import init_order.InitCommon
internal import utils.assert.Assert

main() {
    Assert.isSome(InitCommon.getOrderString().indexOf("A"))
    Assert.isSome(InitCommon.getOrderString().indexOf("B"))
    Assert.isSome(InitCommon.getOrderString().indexOf("C"))
    Assert.isSome(InitCommon.getOrderString().indexOf("D"))
}
