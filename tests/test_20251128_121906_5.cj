/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_02_a01_02

  @Level:         1

  @Assertion:    2.1.12.2(1) For an VArray instance arr, ways for
                 accessing elements in arr are shown as follows:
                 Element at a specific location can be accessed through 
                 arr[index1]...[indexN] (where index1,...,indexN
                 are expressions for the index value, whose types are all Int64).
  
  @Description:  Access to 2-dim VArray


  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/


import utils.assert.Assert


main() {
    let arr0: VArray<VArray<Int64, $2>, $3> = [ [0, 0], [1, 1], [2, 2] ]
    Assert.equals(0, arr0[0][0])
    Assert.equals(1, arr0[1][1])
    Assert.equals(2, arr0[2][0])
    0
}