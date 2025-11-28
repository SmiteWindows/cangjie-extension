/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a17_01

  @Level:         1

  @Assertion:    2.3.1(17) The following examples illustrate the conversion between Float32 and Float64:
                    main() {
                        var f32Number: Float32 = 1.1
                        var f64Number: Float64 = 0.0
                        f64Number = Float64(f32Number) // f64Number = 1.100000023841858
                        f32Number = Float32(f64Number) // f32Number = 1.1
                        f64Number = 1.123456789
                        f32Number = Float32(f64Number) // f32Number = 1.1234568
                        f32Number = 4.4E38 // f32Number = POSITIVE_INFINITY
                        f64Number = Float64(f32Number) // f64Number = POSITIVE_INFINITY
                        f64Number = 4.4E38
                        f32Number = Float32(f64Number) // f32Number = POSITIVE_INFINITY
                        f64Number = f32Number*0.0
                        f32Number = Float32(f64Number) // f32Number = NaN
                        return 0
                    } 

  @Description:  Check example

  @Mode:         run

  @Negative:     no

  @CompileWarning: Ignore

  @Issue:        0006314
*/

import utils.assert.Assert

main() {
    var f32Number: Float32 = 1.1
    var f64Number: Float64 = 0.0
    f64Number = Float64(f32Number) // f64Number = 1.100000023841858
    f32Number = Float32(f64Number) // f32Number = 1.1

    Assert.approxEquals(1.100000023841858, f64Number)
    Assert.approxEquals(1.1, f32Number)

    f64Number = 1.123456789
    f32Number = Float32(f64Number) // f32Number = 1.1234568

    Assert.approxEquals(1.1234568, f32Number)

    f32Number = 4.4E38 // f32Number = POSITIVE_INFINITY
    f64Number = Float64(f32Number) // f64Number = POSITIVE_INFINITY

    Assert.isTrue(f64Number.isInf())
    Assert.isTrue(f32Number.isInf())

    let n1 = 4.4E38 // 这里使用 var 在fast math下无法得到此结果
    let n2 = Float32(n1) //  = POSITIVE_INFINITY
    let n3 = Float64(n2) * 0.0
    let n4 = Float32(n3) //  = NaN
    Assert.isTrue(n2.isInf())
    Assert.isTrue(n4.isNaN())

    return 0
 }