/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a05_02

  @Level:         1

  @Assertion:    3.3.2.2(5) For variables declared in different files of the same package, or in different packages,
                 the initialization is done following the dependence relation between files (or packages)

  @Description:  Check initialization order for global variables declared in different files. Another file order.

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main

  @Dependencies: aux_test_a05_02_1.cj aux_test_a05_02_2.cj ../../init_order/init_common.cj

  @Issue:        0006065

*/

internal import init_order.InitCommon
import utils.assert.Assert

var vInt32: Int32 = InitCommon.initInt32("A")
let vStr = InitCommon.initStr("B")

main() {
    vF32 = 5.3
    Assert.isTrue(InitCommon.getOrderString() == "ABDC")
}
