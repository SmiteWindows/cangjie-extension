/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a13_24_bitwise_right_shift_f32_neg

  @Level:         1

  @Assertion:    1.4(13) >> Bitwise right shift >> Bitwise right shift

  @Description:  Emit error if right shift (>>) uses float operands.  Float32.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:


*/



type TestedType = Float32;
let ct0        :  TestedType  = 0.0f32
let ct_opnd1   :  TestedType  = -3.3f32
let ct_opnd2   :  TestedType  = -2.0f32

var RTZero : TestedType =  ct_opnd1;


main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}
    var rt_opnd1: TestedType = ct_opnd1 +  RTZero;
    var rt_opnd2: TestedType = ct_opnd2 +  RTZero;

    ct_opnd1 >> rt_opnd2
    0
}
