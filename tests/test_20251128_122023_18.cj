/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a18_01

  @Level:         1

  @Assertion:    3.2.3.2(18) The scope of the parameters of lambda expressions is similar to that of function 
                 parameters. For instance, their scope level is the same as the variables defined in the body 
                 of the lambda expression.

  @Description:  Check that the scope of lambda expression arguments ends with the closing of the lambda body.

  @Mode:          run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

main() {
// test case #1
    var y1 : Bool = false
    var y2 : Bool = true
    let foo1 : (Bool, Bool) -> Unit = { y1 : Bool, y2 : Bool =>
        Assert.isTrue(y1)
        Assert.isFalse(y2)
    }

    foo1(true, false)
    Assert.isFalse(y1)
    Assert.isTrue(y2)

// test case #2
    let str = "bla-bla"
    let foo2 : (String) -> Unit = { s : String =>
        Assert.equals("bla-bla", s)
        let str = "foo2"        
    }

    foo2(str)
    Assert.equals("bla-bla", str)
}
