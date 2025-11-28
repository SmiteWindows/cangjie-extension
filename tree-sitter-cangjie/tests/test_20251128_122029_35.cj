/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a06_05_i16

  @Level:         1

  @Assertion:    1.4(6) - Unary negative

  @Description:  Check lexical ability of unary minus - . Type Int16.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = Int16;
let ct0   :  TestedType  =  0i16
let ct1   :  TestedType  =  1i16
let ct_1  :  TestedType  = -1i16

var RTZero : TestedType =  ct_1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}

    var ct_pos : TestedType=ct1;
    var rt_pos: TestedType=RTZero + 1;

    var ct_neg : TestedType=ct_1;
    var rt_neg : TestedType=RTZero - 1;


    Assert.equals(-ct_pos,-rt_pos)
    Assert.equals(-rt_pos,ct_1)

    Assert.equals(-ct_neg,-rt_neg)
    Assert.equals(-rt_neg,ct1)
    Assert.equals(-ct0,ct0)
    Assert.equals(-RTZero,RTZero)
    0
}
