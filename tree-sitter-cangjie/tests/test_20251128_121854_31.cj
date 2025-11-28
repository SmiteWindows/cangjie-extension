/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a29_01_assign

  @Level:         1

  @Assertion:    1.4(29) = Assignment

  @Description:  Assignments uses everwhere. Check thick assignmentd

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

var RTZero : Int32 = 1;
struct Rect {
    var wid: Int32 = 0
    var len: Int32 = 0
}

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) { RTZero = 0; }

    var sv : Rect = Rect();
    sv.wid = 10 + RTZero
    sv.len = 20 + RTZero
    var sv2 : Rect ; 
    sv2 = sv
    Assert.equals(sv2.wid, 10)
    Assert.equals(sv2.len, 20)
    return 0;
}
