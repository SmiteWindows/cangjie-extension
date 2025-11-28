/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a32_02_diva_i16

  @Level:         1

  @Assertion:    1.4(32) /=

  @Description:  Check lexical ability of Compound assignment (/=)  Int16.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/


import utils.assert.Assert

type TestedType = Int16;
let ct0        :  TestedType  =  0i16
let ct_opnd1   :  TestedType  =  3i16
let ct_opnd2   :  TestedType  = -2i16

var RTZero : TestedType =  ct_opnd1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 +  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 +  RTZero;
    var res1:TestedType = ct_opnd1;
    var res2:TestedType = rt_opnd1;
    res1 /= ct_opnd2;
    res2 /= rt_opnd2;
    Assert.equals(res1,res2)

    Assert.isTrue(res1 is TestedType)
    0
}