/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_12_a06_01

  @Level:         1

  @Assertion:    2.1.12(6) 3.VArrayis a value type. A variable defined as 
                 a value type stores the data directly instead of via a reference
                 or indirection, so the VArraytype copies the value when performing
                 operations such as assignment or function argument passing.
  
  @Description:  VArray of Int64. Array assignment.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Issue:       0006077

  @Comment:     Compiler emit error on VArray<..., $3>

*/


import utils.assert.Assert


main() {
    let arr1: VArray<Int64, $3> = [13, 4, 5]
    var arr0: VArray<Int64, $3> = arr1;
    Assert.equals(3, arr0.size)
    0
}