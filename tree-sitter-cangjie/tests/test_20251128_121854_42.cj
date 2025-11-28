/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a03_13_index_access_2_neg_1

  @Level:         1

  @Assertion:    1.4(3) . Member access [] Index access () Function call

  @Description:  Emit error Index access has less dimension

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single


*/

import utils.assert.Assert

var RTZero : Int32=1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = 0;}

    var arr:Array<Array<Int32>>=[[1, 2, 3], [10,100,1000]]
    arr[0][Int64(RTZero)] = arr[1][2] + arr[1] + RTZero
    Assert.equals(arr[0][0],Int32(1100))
    Assert.equals(arr[1][1],Int32(100))
    return 0;
}
