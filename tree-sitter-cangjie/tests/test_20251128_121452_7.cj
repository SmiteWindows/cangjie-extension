/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a19_27_neq_neg_1

  @Level:         1

  @Assertion:    1.4(19) == Equal != Not equal

  @Description:  Emit error with incorrect eq operator

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = IntNative;

func BinOp(Operand1:TestedType, Operand2:TestedType): Bool 
    {Operand1 .!= Operand2       // <=   incorrect not equal sign
    }

main(ina :Array<String>) {
    BinOp(ct_opnd1,ct_opnd2)
}