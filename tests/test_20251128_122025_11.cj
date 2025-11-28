/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a21_03_xor_f16

  @Level:         1

  @Assertion:    1.4(21) ^ Bitwise XOR

  @Description:  Emit error with float type.  Float16.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = Float16;

func BinOp(Operxor1:TestedType, Operxor2:TestedType): TestedType { 
    Operxor1 ^ Operxor2
}

main(ina :Array<String>) {
    0
}