/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a23_05

  @Level:         1

  @Assertion:    1.4(23) .. ..= Range operator
 
  @Description:  Using range operator in loop 

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/

import utils.assert.Assert

main(ina :Array<String>) {
    let carr:Array<Int32>=[0,1,2,3,4,5,6,7,8]
    var arr = Array<Int32>(4) {
        i=>0
    }


    var i:Int64 = 0
    for (item in 1..=7 : 2) {
       arr[i] = carr[item]
       i++
    } 

    Assert.equals(4,arr.size)

    Assert.equals(1,arr[0])
    Assert.equals(3,arr[1])
    Assert.equals(5,arr[2])

    0
}
