/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a36_13_aleft_shift_neg

  @Level:         1

  @Assertion:    1.4(36) <<=

  @Description:  Emit error  if left shift (<<) uses one float operand

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/


type TestedType = Int32;
let ct0        :  TestedType  = 0
let ct_opnd1   :  TestedType  = -3
let ct_opnd2   :  TestedType  = -2

var RTZero : TestedType =  ct_opnd1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: Float32 = 13.4
    var rt_opnd2: TestedType = ct_opnd2 +  RTZero;
    rt_opnd1 <<= rt_opnd2
    0
}
