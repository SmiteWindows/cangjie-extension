/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a07_04_power_neg_1

  @Level:         1

  @Assertion:    1.4(7) ** Power

  @Description:  Emit error with wrong sign (separated * *)

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:


*/



type BaseType = Int64
type PowerType =UInt64

let ct0   :  PowerType  =  0u64
let ct1   :  PowerType  =  1u64
var RTZero : PowerType  =  ct1;


main(ina :Array<String>) {
    let z : Bool = 0 == 0
    if (z) {RTZero = ct0;}

    var ctp : PowerType = ct0;
    var rtp : PowerType = RTZero;
    let cbase : BaseType = 2
    cbase* *ctp

    0
}
 

