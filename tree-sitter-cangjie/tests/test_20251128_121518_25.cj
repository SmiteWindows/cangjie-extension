/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_a03_02

  @Level:         1

  @Assertion:    2.1.12(3) If the provided index is greater than or equal 
                 to the length of the VArray, the compiler will report an error
                 when index value can be deduced by complier,
                 otherwise, an exception is thrown at run time.
  
  @Description:  VArray of classes. Array assignment. Example with usual array.
                 Trow exception due to wrong index

  @Mode:         run

  @Negative:     yes

  @Structure:   single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/


import utils.assert.Assert


main(ina :Array<String>) {
    var RTZero : Int64 = -1;
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = 0;}
    try {
        var arr1: VArray<Int64, $3> = VArray<Int64, $3> { i => i }
        arr1[RTZero + 4 ]
        Assert.fail()
    } catch (_) {
    }
    0
}