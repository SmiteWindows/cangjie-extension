/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_02_a03_04

  @Level:         1

  @Assertion:    3.3.2.2(3) All global/static variables are initialized before the execution of the main (the entry
                 point);

  @Description:  Check that struct static variables are initialized before main.

  @Mode:         run

  @Negative:     no

  @Structure:    complex-main
  
  @Dependencies: ../init_order/init_common.cj

*/

import init_order.InitCommon
import utils.assert.Assert

struct Test {
    static var sInt: Int32 = InitCommon.initInt32("A")
    static var sTuple = InitCommon.initTuple("B")
    static var sBool = InitCommon.initBool("C")
    static var sRange: Range<Int32> = InitCommon.initRange("D")
}

main() {
    Assert.isSome(InitCommon.getOrderString().indexOf("A"))
    Assert.isSome(InitCommon.getOrderString().indexOf("B"))
    Assert.isSome(InitCommon.getOrderString().indexOf("C"))
    Assert.isSome(InitCommon.getOrderString().indexOf("D"))
}
