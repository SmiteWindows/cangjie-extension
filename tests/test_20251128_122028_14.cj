/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a21_11_xor_neg_1

  @Level:         1

  @Assertion:    1.4(21) ^ Bitwise XOR

  @Description:  Emit error with incorrect xor operator

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = IntNative;

func BinOp(Operxor1:TestedType, Operxor2:TestedType): TestedType { 
    Operxor1 .^ Operxor2       // <=   incorrect xor sign
}

main(ina :Array<String>) {
    0
}