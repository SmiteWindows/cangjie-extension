/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a03_08_index_access_1_neg_1

  @Level:         1

  @Assertion:    1.4(3) . Member access [] Index access () Function call

  @Description:  Emit error if index access is empty

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single


*/

import utils.assert.Assert

var RTZero : Int32=1;

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = 0;}
    var arr:Array<Int32>=[0,2,4]
    arr[0] = arr[1] + arr[] + RTZero
    Assert.equals(arr[Int64(RTZero)],Int32(6))
    return 0;
}
