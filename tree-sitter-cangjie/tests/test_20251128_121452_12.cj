/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a41_01_aand_bool

  @Level:         1

  @Assertion:    1.4(41) &&=

  @Description:  Check lexical ability of Compound assignmen with logical AND (=&&).

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

  @Issue:        6585

*/


import utils.assert.Assert

type TestedType = Bool;
let ctOpnd1   :  TestedType  =  false
let ctOpnd2   :  TestedType  =  true


main(ina :Array<String>) {
    var RTZero : TestedType =  Assert.getRuntimeZero(ina) != 0
    var rtOpnd1: TestedType = ctOpnd1 &&  RTZero;
    var rtOpnd2: TestedType = ctOpnd2 &&  RTZero;
    var res1: TestedType =  ctOpnd1;
    var res2: TestedType =  rtOpnd1;
    res1 &&= ctOpnd2;
    res2 &&= rtOpnd2;
    Assert.equals(res1, res2)
    res1 = ctOpnd1
    res2 = rtOpnd1
    Assert.equals(res1, res2)
    0
}