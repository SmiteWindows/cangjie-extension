/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a14_05_less_i32

  @Level:         1

  @Assertion:    1.4(14) < Less than
 
  @Description:  Check lexical ability of less than (<)  Int32.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = Int32;
let ct0        :  TestedType  =  0i32
let ct_opnd1   :  TestedType  =  3i32
let ct_opnd2   :  TestedType  = -2i32

var RTZero : TestedType =  ct_opnd1;

func BinOp(Operand1:TestedType, Operand2:TestedType): Bool 
    {Operand1 < Operand2
    }

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 -  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 -  RTZero;
    Assert.equals(ct_opnd1 < ct_opnd2,rt_opnd1 < rt_opnd2)
    Assert.equals(ct_opnd1 < rt_opnd2,rt_opnd1 < ct_opnd2)
    Assert.equals(BinOp(ct_opnd1,ct_opnd2),BinOp(rt_opnd1,rt_opnd2))

    Assert.isTrue((ct_opnd1 < rt_opnd2) is Bool)
    0
}