/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a19_18_neq_char

  @Level:         1

  @Assertion:    1.4(19) == Equal != Not equal

  @Description:  Check lexical ability of inequality (!=)  Rune

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = Rune;
let ct0        :  TestedType  = r'\0'
let ct_opnd1   :  TestedType  = r'X'
let ct_opnd2   :  TestedType  = r'Y'


func BinOp(Operand1:TestedType, Operand2:TestedType): Bool 
    {Operand1 != Operand2
    }

main(ina :Array<String>) {
    var rt_opnd1: TestedType = ct0;
    var rt_opnd2: TestedType = ct0;
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {
        rt_opnd1 = ct_opnd1;
        rt_opnd2 = ct_opnd2;
    }
    Assert.equals(ct_opnd1 != ct_opnd2,rt_opnd1 != rt_opnd2)
    Assert.equals(ct_opnd1 != rt_opnd2,rt_opnd1 != ct_opnd2)
    Assert.equals(BinOp(ct_opnd1,ct_opnd2),BinOp(rt_opnd1,rt_opnd2))

    Assert.isTrue((ct_opnd1 != rt_opnd2) is Bool)

    Assert.isTrue(r'X' != rt_opnd2)
    Assert.isTrue(r'Y' != rt_opnd1)

    0
}