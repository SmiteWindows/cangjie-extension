/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a08_03

  @Level:         1

  @Assertion: 2.1.10.2(8)
              The syntax and semantics of regular parameters are consistent 
              with those in the function definition.

  @Description: Check that default values for parameters are evaluated during
                the primary constructor invocation

  @Mode: run

  @Negative: no

  @Structure: single

  @Comment: Excerpt from 5.1.2 Parameters:
            The default value of the parameter is evaluated when the function is called,
            not when the function is defined.

*/

import utils.assert.Assert

var global_var = 0

func default_param() {
    return global_var
}

struct A {
    A(a!: Int64 = default_param()) {
        Assert.equals(10, a)
    }
}

main() {
    global_var = 10
    let a = A()
}
