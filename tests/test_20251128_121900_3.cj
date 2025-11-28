/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_04_02_a03_01

  @Level:         1

  @Assertion:    2.4.2(3) If it is a type alias for class, struct, it can be used as a constructor
 
  @Description:  Check that the class\struct alias can be used as a constructor  

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

type s = S
type c = C

struct S {}
open class C {}


main(): Unit {
    let a1 = s()
    let a2 = c()

    Assert.isTrue(a1 is S)
    Assert.isTrue(a2 is C)
    Assert.isTrue(a2 is Object)
}
