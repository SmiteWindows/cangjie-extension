/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a03_01

  @Level:         1

  @Assertion:    2.1.12.1(3) The length of VArray must be of the literal type Int64
                 and must be the same as the length of the provided literal array.
  
  @Description:  Check sizes conformity. Check type of size.

  @Mode:         run

  @Negative:     no

  @Structure:    single



*/


import utils.assert.Assert

type TestedType = Int32;

let zero: TestedType = 0i32
let one: TestedType = 1i32
let two: TestedType = 2i32

main() {
    let arr1: VArray<TestedType, $3> = [zero, one, two]
    Assert.equals(3, arr1.size)
    let arrsz = arr1.size;
    Assert.isTrue(arrsz is Int64)
    0
}