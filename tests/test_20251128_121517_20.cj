/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a08_17_mul_neg_1

  @Level:         1

  @Assertion:    1.4(8) * Multiply

  @Description:  Emit error with incorrect mul operator

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = IntNative;

func BinOp(Operand1:TestedType, Operand2:TestedType): TestedType 
    {Operand1 .* Operand2       // <=   incorrect mul sign
    }

main(ina :Array<String>) {
    0
}