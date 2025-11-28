/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_04_a03_05_function_call_1_neg_4

  @Level:         1

  @Assertion:    1.4(3) . Member access [] Index access () Function call

  @Description:  Emit error with wrong call name

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single



*/

import utils.assert.Assert

var RTZero : Int64=-1;

func add(p1: Int64, p2: Int64):Int64
{
    Assert.equals(p1,2)
    Assert.equals(p2,3)
    p1 + p2 + RTZero
}
func mul(p1: Int64, p2: Int64):Int64
{ 
    Assert.equals(p1,7)
    Assert.equals(p2,3)
    p1 * p2 + RTZero
}

main(ina :Array<String>) {
    let z : Bool = Assert.getRuntimeZero(ina) == 0
    if (z) {RTZero = 0;}

    Assert.equals(_add(3+RTZero),5)
    Assert.equals(mul(1,3),21)
    return 0;
}
