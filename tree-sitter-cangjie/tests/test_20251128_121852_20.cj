/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_04_a02_01

  @Level:         1

  @Assertion:    2.1.12.4(2) func mergeArray<T>(a: VArray<T, $2>, b: VArray<T, $3>): VArray<T, $5>
  
  @Description:  Example with VArray function

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/


import utils.assert.Assert


func mergeArray(a: VArray<Int64,$2>, b: VArray<Int64, $3>): VArray<Int64, $5> {
    var arrR: VArray<Int64, $5> = VArray<Int64, $5>(repeat: 0)
    arrR[0] = a[0]
    arrR[1] = a[1]
    arrR[2] = b[0]
    arrR[3] = b[1]
    arrR[4] = b[2]
    arrR
}

main() {
    let arr1: VArray<Int64, $2> = [0, 1]
    let arr2: VArray<Int64, $3> = [2, 3, 4]
    var arr0: VArray<Int64, $5> = mergeArray(arr1, arr2)
    Assert.equals(0, arr0[0])
    Assert.equals(1, arr0[1])
    Assert.equals(2, arr0[2])
    Assert.equals(3, arr0[3])
    Assert.equals(4, arr0[4])
    0
}