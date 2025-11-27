/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a12_26_sub_u8_revert

  @Level:         1

  @Assertion:    1.4(12) - Subtract

  @Description:  transposition  will cause exception  UInt8.

  @Mode:         run

  @Negative:     yes

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = UInt8;
let ct0        :  TestedType  = 0u8
let ct_opnd1   :  TestedType  = 3u8
let ct_opnd2   :  TestedType  = 2u8

var RTZero : TestedType =  ct_opnd1;

func BinOp(Operand1:TestedType, Operand2:TestedType): TestedType 
    {Operand1 - Operand2
    }
func BinOpR(Operand1:TestedType, Operand2:TestedType): TestedType 
    {ct0 - (Operand2 - Operand1)
    }

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 -  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 -  RTZero;
    Assert.equals(ct_opnd1 - ct_opnd2,rt_opnd1 - rt_opnd2)
    Assert.equals(ct_opnd1 - rt_opnd2,rt_opnd1 - ct_opnd2)
    Assert.equals(BinOp(ct_opnd1,ct_opnd2),BinOpR(rt_opnd1,rt_opnd2))

    Assert.isTrue((ct_opnd1 - rt_opnd2) is TestedType)
    0
}
