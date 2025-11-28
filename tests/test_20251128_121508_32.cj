/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a03_17_member_access_neg_3

  @Level:         1

  @Assertion:    1.4(3) . Member access [] Index access () Function call

  @Description:  Check correctness of syntax (.Field) extra brackets after

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single


*/

import utils.assert.Assert

var RTZero : Int32=1;
struct Rect {
    var wid: Int32 = 10
    var len: Int32 = 20
}

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = 0;}

    var sv : Rect = Rect();
    sv.wid = sv.wid+RTZero
    sv.len = sv.len()+RTZero + 1
    Assert.equals(sv.wid,10)
    Assert.equals(sv.len,21)
    return 0;
}
