/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a04_03_id_1_i64

  @Level:         1

  @Assertion:    1.4(4) ++ Postfix increment -- Postfix decrement ? Question mark

  @Description:  Check lexical ability of ++ and --.  Int64

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:


*/


import utils.assert.Assert

type TestedType = Int64;
let ct0   :  TestedType  =  0i64
let ct1   :  TestedType  =  1i64
let ct_1  :  TestedType  = -1i64

var RTZero : TestedType =  ct_1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = ct0;}

    var inc_ct : TestedType=ct0;
    var inc_rt : TestedType=RTZero;

    var dec_ct : TestedType=ct0;
    var dec_rt : TestedType=RTZero;

    inc_ct++; inc_rt++;
    dec_ct--; dec_rt--;

    Assert.equals(inc_ct,inc_rt)
    Assert.equals(inc_ct,ct1)

    Assert.equals(dec_ct,dec_rt)
    Assert.equals(dec_ct,ct_1)
    0
}