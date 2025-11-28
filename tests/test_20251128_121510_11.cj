/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_03_a08_06

  @Level:         1
  @Assertion:       2.1.1.3(8) NaN op num = NaN | op is any arithmetic operator, and num can be any floating point
                    number (including NaN, 0, POSITIVE_INFINITY and NEGATIVE_INFINITY)

  @Description:     Check that (n op NaN = NaN) where op is one of the {+, -, *, /, **} operations and n is a
                    Float64/32/16 number.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006075,0006385
*/

import utils.assert.Assert

main(inp: Array<String>) {
    Assert.isTrue((.1 + Float64.NaN).isNaN())
    Assert.isTrue((.01 + Float32.NaN).isNaN())
    Assert.isTrue((.001 + Float16.NaN).isNaN())

    Assert.isTrue((-0.1 - Float64.NaN).isNaN())
    Assert.isTrue((-0.01 - Float32.NaN).isNaN())
    Assert.isTrue((-0.001 - Float16.NaN).isNaN())

    Assert.isTrue((6.0 * Float64.NaN).isNaN())
    Assert.isTrue((6.1 * Float32.NaN).isNaN())
    Assert.isTrue((6.01 * Float16.NaN).isNaN())

    Assert.isTrue((-6.0 / Float64.NaN).isNaN())
    Assert.isTrue((-6.1 / Float32.NaN).isNaN())
    Assert.isTrue((-6.01 / Float16.NaN).isNaN())

    Assert.isTrue((Float64.NaN ** 99999999.0).isNaN())
    Assert.isTrue((Float64.NaN ** 1111111111).isNaN())

    // Returns some number.
    let getN64 = { => Float64(Assert.getRuntimeZero(inp)) + 0.9 }
    let getN32 = { => Float32(Assert.getRuntimeZero(inp)) + 56.9 }
    let getN16 = { => Float16(Assert.getRuntimeZero(inp)) + 13.33 }
    Assert.isTrue((-getN64() + Float64.NaN).isNaN())
    Assert.isTrue((-getN32() + Float32.NaN).isNaN())
    Assert.isTrue((-getN16() + Float16.NaN).isNaN())

    Assert.isTrue((getN64() - Float64.NaN).isNaN())
    Assert.isTrue((getN32() - Float32.NaN).isNaN())
    Assert.isTrue((getN16() - Float16.NaN).isNaN())

    Assert.isTrue((-getN64() * Float64.NaN).isNaN())
    Assert.isTrue((-getN32() * Float32.NaN).isNaN())
    Assert.isTrue((-getN16() * Float16.NaN).isNaN())

    Assert.isTrue((getN64() / Float64.NaN).isNaN())
    Assert.isTrue((getN32() / Float32.NaN).isNaN())
    Assert.isTrue((getN16() / Float16.NaN).isNaN())

    Assert.isTrue((getN64() ** Float64.NaN).isNaN())
}
