/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a11_18_add_neg_2

  @Level:         1

  @Assertion:    1.4(11) + Add

  @Description:  Emit error if operands have different types

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



func BinOp(Operand1:Float16, Operand2:Int16)
    {Operand1 + Operand2  // add with different types
    0
    }

main(ina :Array<String>) {
    0
}
