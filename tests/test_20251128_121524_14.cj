/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a02_08

  @Level:         1

  @Assertion:    2.1.12.1(2) This approach can only be used if it is clear
                 from the context that the literal is of type VArray,
                 otherwise it will still preferentially be inferred as Array.
  
  @Description: W/O type object is treated as usual Array

  @Mode:         run

  @Negative:     no

  @Structure:    single



*/


import utils.assert.Assert

type TestedType = UInt8;
let zero  :  TestedType  =  0u8
let one   :  TestedType  =  1u8
let two   :  TestedType  =  2u8

main() {
    let arr1 = [zero, one, two]
    Assert.equals(zero, arr1[0])
    var arr0 = arr1;
    Assert.equals(zero, arr0[0])
    Assert.equals(one, arr0[1])
    Assert.equals(two, arr0[2])
    0
}