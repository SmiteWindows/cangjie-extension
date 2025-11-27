/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a37_10_aright_shift_i64

  @Level:         1

  @Assertion:    1.4(37) >>=

  @Description:  Check lexical ability of right shift (=>>)  Int64.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/


import utils.assert.Assert

type TestedType = Int64;
let ct0        :  TestedType  =  0i64
let ct_opnd1   :  TestedType  =  3i64
let ct_opnd2   :  TestedType  =  2i64

var RTZero : TestedType =  ct_opnd1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 +  RTZero;
    var rt_opnd2 : TestedType = ct_opnd2 +  RTZero;
    var rct : TestedType = ct_opnd1;
    var rrt : TestedType = rt_opnd1;
    rct >>=  ct_opnd2
    rrt >>=  rt_opnd2
    Assert.equals(rct, rrt)
    0
}
