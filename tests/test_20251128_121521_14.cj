/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a13_01

  @Level:         1

  @Assertion:   2.4.1(13) The alias defined in the type definition is treated as a type who is same to 
                the original type.

  @Description: Check that the alias is treated as a original type

  @Mode:        run

  @Negative:    no

*/

import utils.assert.Assert

type D3 = (Float64, Float64, Float64)

main(): Unit {
    var a: (Float64, Float64, Float64) = (1178.22, -456.34, 0.00)
    let b: D3 = (1178.22, -456.34, 0.00)
    let c: D3 = a

    Assert.isTrue(a is (Float64, Float64, Float64))
    Assert.isTrue(a is D3)

    Assert.isTrue(b is (Float64, Float64, Float64))
    Assert.isTrue(b is D3)

    Assert.isTrue(c is (Float64, Float64, Float64))
    Assert.isTrue(c is D3)

    Assert.equals(a[0], b[0])
    Assert.equals(a[1], b[1])
    Assert.equals(a[2], b[2])
}
