/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a06_14_u32_neg_rt

  @Level:         1

  @Assertion:    1.4(6) - Unary negative

  @Description:  Test shows imposibility unar minus for unsigned
                 Exception will happen

  @Mode:         run	

  @Negative:     yes

  @Structure:    single

  @Comment:


*/



import utils.assert.Assert

type TestedType = UInt32;

let ct0   :  TestedType  =  0u32
let ct1   :  TestedType  =  1u32
var RTZero : TestedType =  ct1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}

    var rt_pos: TestedType= -(RTZero + ct1)
    println(rt_pos)
}
