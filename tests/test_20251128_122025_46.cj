/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_02_a02_01

  @Level:         1

  @Assertion:    2.4.2(2) 
                    type A = B
                    class B {}
                    var a: A = B() // Use typealias A as type 

 
  @Description:  Check example

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

type A = B
class B {}
var a: A = B() // Use typealias A as type 

main(): Unit {
    Assert.isTrue(a is A)
    Assert.isTrue(a is B)
}

