/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a39_14_axor_u32

  @Level:         1

  @Assertion:    1.4(39) ^=

  @Description:  Check lexical ability of Compound assignment for bitwise XOR (^=)  UInt32.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = UInt32;
let ct0        :  TestedType  = 0u32
let ct_opnd1   :  TestedType  = 3u32
let ct_opnd2   :  TestedType  = 2u32

var RTZero : TestedType =  ct_opnd1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 -  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 -  RTZero;
    var r1: TestedType = ct_opnd1;
    var r2: TestedType = rt_opnd1;
    r1 ^= ct_opnd2
    r2 ^= rt_opnd2
    Assert.equals(r1,r2)
    0
}