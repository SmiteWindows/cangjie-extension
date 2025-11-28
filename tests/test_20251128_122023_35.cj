/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a01_11

  @Level:         1

  @Assertion:   2.1.12.1(1) VArray instances can also be created by Array literals.
  
  @Description:  VArray of base type initiated by array of literals

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $..>

*/


import utils.assert.Assert

type TestedType = Float16;
let zero  :  TestedType  =  0.0f16
let one   :  TestedType  =  1.0f16
let two   :  TestedType  =  2.0f16

main() {
    let arr1: VArray<TestedType, $3> = [zero, one, two]
    Assert.equals(zero, arr1[0])
    var arr0: VArray<TestedType, $3> = arr1;
    Assert.equals(zero, arr0[0])
    Assert.equals(one, arr0[1])
    Assert.equals(two, arr0[2])
    0
}