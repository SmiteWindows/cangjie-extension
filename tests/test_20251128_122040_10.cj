/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a22_04_or_f32

  @Level:         1

  @Assertion:    1.4(22) | Bitwise OR

  @Description:  Emit error with float type.  Float32.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = Float32;

func BinOp(Operor1:TestedType, Operor2:TestedType): TestedType { 
    Operor1 | Operor2
}

main(ina :Array<String>) {
    0
}