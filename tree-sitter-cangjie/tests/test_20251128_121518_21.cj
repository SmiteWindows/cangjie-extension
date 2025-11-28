/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a09_10_div_neg_2

  @Level:         1

  @Assertion:    1.4(9) / Divide

  @Description:  Emit error if operands have different types

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = IntNative;
let ct_opnd2   :  TestedType  = -2

var RTZero : TestedType =  ct_opnd1;


main(ina :Array<String>) {
    1.0/ct_opnd2

    0
}