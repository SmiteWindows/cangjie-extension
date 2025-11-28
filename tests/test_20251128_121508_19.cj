/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a11_01

  @Level:         1

  @Assertion:    3.2.3.2(11) Its scope level is the same as the variables defined in the function body.

  @Description:  Check that the scope of function argument is the same with the function variables.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
    let v : String = "bla-bla"
    let a : Int64   = -1
    let b : Float64 = -1.0
    func foo(a : Int32, b : Int32) {
        let v : Int32 = 3
        Assert.equals(1, a)
        Assert.equals(2, b)
        Assert.equals(3, v)
    }

    foo(1, 2)
    Assert.equals(-1,   a)
    Assert.equals(-1.0, b)
    Assert.equals("bla-bla", v)
}
