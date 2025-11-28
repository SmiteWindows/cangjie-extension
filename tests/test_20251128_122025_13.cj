/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_a05_02

  @Level:         1

  @Assertion:   2.4(5) The alias and the original type are regarded as the same type, and the alias does not affect the
                use of the original type.

  @Description: Check that the alias does not affect the use of the original type

  @Mode:        run

  @Negative:    no


*/

import utils.assert.Assert

type myType = Float64

func foo(t: Float64) { t/2.5 }

type myType2 = Float64

main(): Unit {
    var a: myType = 7.5

    Assert.equals(2.0, foo(5.0_f64))
    Assert.equals(3.0, foo(a))
}