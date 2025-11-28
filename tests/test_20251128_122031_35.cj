/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a04_01

  @Level:         1

  @Assertion:    2.1.12.1(4) Otherwise, an error is reported during compilation.
  
  @Description:  Must emit error due sizes discrepancy

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/



type TestedType = Int32;

let zero: TestedType = 0i32
let one: TestedType = 1i32
let two: TestedType = 2i32

main() {
    let arr1: VArray<TestedType, $2> = [zero, one, two]
    0
}