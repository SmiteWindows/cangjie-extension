/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a36_14_aleft_shift_u16

  @Level:         1

  @Assertion:    1.4(36) <<=

  @Description:  Check lexical ability of left shift (<<)  UInt16.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = UInt16;
let ct0        :  TestedType  = 0u16
let ct_opnd1   :  TestedType  = 3u16
let ct_opnd2   :  TestedType  = 2u16

var RTZero : TestedType =  ct_opnd1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 +  RTZero;
    var rt_opnd2 : TestedType = ct_opnd2 +  RTZero;
    var rct : TestedType = ct_opnd1;
    var rrt : TestedType = rt_opnd1;
    rct <<=  ct_opnd2
    rrt <<=  rt_opnd2
    Assert.equals(rct, rrt)
    0
}
