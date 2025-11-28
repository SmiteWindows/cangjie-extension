/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_01_a07_01

  @Level:         1

  @Assertion:   2.1.12.1(7) // VArray<T, $N>(initElement: (Int64)->T)
                let arr5: VArray <Int64 ,$5> = VArray<Int64 ,$5> { i=>i } // [0, 1, 2, 3, 4]
                let arr6: VArray <Int64 ,$5> = VArray<Int64 ,$5>(repeat:0) // [0, 0, 0, 0, 0]
  
  @Description:  Proposed example with item. let arr6 :VArray <Int64 ,$5>=VArray <Int64 ,$5>(repeat:0

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $..>

*/
import utils.assert.Assert
main() {
    let arr6: VArray<Int64 ,$5> = VArray<Int64 ,$5>(repeat:0) // [0, 0, 0, 0, 0]
    Assert.equals(0, arr6[0])
    Assert.equals(0, arr6[1])
    Assert.equals(0, arr6[2])
    Assert.equals(0, arr6[3])
    Assert.equals(0, arr6[4])
    0
}