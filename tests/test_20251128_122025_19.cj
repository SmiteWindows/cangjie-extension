/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a13_31_bitwise_right_shift_neg_1

  @Level:         1

  @Assertion:    1.4(13) >> Bitwise right shift >> Bitwise right shift

  @Description:  Emit error with negative right shift (>>) sign

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/



type TestedType = IntNative;
let ct0        :  TestedType  =  0
let ct_opnd1   :  TestedType  =  3
let ct_opnd2   :  TestedType  = -2



main(ina :Array<String>) {
    ct_opnd1 >> ct_opnd2
    0
}
