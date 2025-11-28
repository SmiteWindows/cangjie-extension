/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a29_01

  @Level:         1

  @Assertion:    2.3.1(29)  
                    main() {
                        var i32Number: Int32 = 1024
                        var f16Number: Float16 = 0.0
                        var f32Number: Float32 = 0.0
                        f16Number = Float16(i32Number) // ok: f16Number = 1024.0
                        f32Number = Float32(i32Number) // ok: f32Number = 1024.0
                        i32Number = 2147483647
                        f16Number = Float16(i32Number) // f16Number = POSITIVE_INFINITY
                        f32Number = Float32(i32Number) // precision lost: f32Number = 2.14748365E9
                        f32Number = 1024.1024
                        i32Number = Int32(f32Number) // ok: i32Number = 1024
                        f32Number = 1024e10
                        i32Number = Int32(f32Number) // throw an ArithmeticException: (Int32)f32Number is not in the 
                                                        range of Int32
                        f32Number = 3.4e40 // f32Number = POSITIVE_INFINITY
                        i32Number = Int32(f32Number) // throw an ArithmeticException
                        f32Number = 3.4e40 * 0.0 // f32Number = NaN
                        i32Number = Int32(f32Number) // throw an ArithmeticException
                        return 0
                    }

  @Description:  Positive example check

  @Mode:         run

  @Negative:     no

  @CompileWarning: Ignore
*/

import utils.assert.Assert

main() {
    var i32Number: Int32 = 1024
    var f16Number: Float16 = 0.0
    var f32Number: Float32 = 0.0
    f16Number = Float16(i32Number) // ok: f16Number = 1024.0
    f32Number = Float32(i32Number) // ok: f32Number = 1024.0

    Assert.approxEquals(1024.0, f16Number)
    Assert.approxEquals(1024.0, f32Number)

    i32Number = 2147483647
    f16Number = Float16(i32Number) // f16Number = POSITIVE_INFINITY
    f32Number = Float32(i32Number) // precision lost: f32Number = 2.14748365E9

    Assert.isTrue(f16Number.isInf() && f16Number > 0.0)
    Assert.approxEquals(2.14748365E9, f32Number)

    f32Number = 1024.1024
    i32Number = Int32(f32Number) // ok: i32Number = 1024

    Assert.equals(1024, i32Number)

    f32Number = 3.4e40 // f32Number = POSITIVE_INFINITY

    Assert.isTrue(f32Number.isInf() && f32Number > 0.0)

    f32Number = 3.4e40 * 0.0 // f32Number = NaN

    Assert.isTrue(f32Number.isNaN())
    
    return 0
}