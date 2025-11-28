/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a30_08_comp_power_neg_f32

  @Level:         1

  @Assertion:    1.4(30) **= Compound assignment

  @Description:  Emit error with base UInt32

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


import utils.assert.Assert

type BaseType = Float32
type PowerType =UInt16

let ct0   :  PowerType  =  0u16
let ct1   :  PowerType  =  1u16
var RTZero : PowerType  =  ct1;


main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}

    var ctp : PowerType = ct0;
    var rtp : PowerType = RTZero;
    var cbase : BaseType = 2.0
    cbase **=rtp
    0
}
 

