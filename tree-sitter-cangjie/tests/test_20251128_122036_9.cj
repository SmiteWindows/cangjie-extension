/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a21_15_xor_u64

  @Level:         1

  @Assertion:    1.4(21) ^ Bitwise XOR

  @Description:  Check lexical ability of Bitwise XOR (^)  UInt64.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/


import utils.assert.Assert

type TestedType = UInt64;
let ct0        :  TestedType  = 0u64
let ct_opnd1   :  TestedType  = 3u64
let ct_opnd2   :  TestedType  = 2u64

var RTZero : TestedType =  ct_opnd1;

func BinOp(Operxor1:TestedType, Operxor2:TestedType): TestedType { 
    Operxor1 ^ Operxor2
}

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 -  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 -  RTZero;
    Assert.equals(ct_opnd1 ^ ct_opnd2,rt_opnd1 ^ rt_opnd2)
    Assert.equals(ct_opnd1 ^ rt_opnd2,rt_opnd1 ^ ct_opnd2)
    Assert.equals(BinOp(ct_opnd1,ct_opnd2),BinOp(rt_opnd1,rt_opnd2))

    Assert.isTrue((ct_opnd1 ^ rt_opnd2) is TestedType)
    0
}