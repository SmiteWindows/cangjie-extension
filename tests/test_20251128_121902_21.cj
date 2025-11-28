/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a20_03

  @Level:         1

  @Assertion:    2.3.1(20) The following shows example conversions between between Int8 and UInt8 using the strategy
                 of throwing exceptions:

                 main() {
                     var i8Number: Int8 = 127
                     var u8Number: UInt8 = 0
                     u8Number = UInt8(i8Number) // ok: u8Number = 127
                     u8Number = 100
                     i8Number = Int8(u8Number) // ok: i8Number= 100
                     i8Number= -100
                     u8Number = UInt8(i8Number) // throw an ArithmeticException
                     u8Number = 255
                     i8Number = Int8(u8Number) // throw an ArithmeticException
                     return 0
                 }

  @Description:  Checking that the example causes an exception in the first case

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main() {
    Assert.throws({ =>     
        var i8Number: Int8 = 127
        var u8Number: UInt8 = 0
        u8Number = UInt8(i8Number) // ok: u8Number = 127
        u8Number = 100
        i8Number = Int8(u8Number) // ok: i8Number= 100
        u8Number = 255
        i8Number = Int8([u8Number][0]) // throw an ArithmeticException
    }, check: { e => e is ArithmeticException})
    return 0
}