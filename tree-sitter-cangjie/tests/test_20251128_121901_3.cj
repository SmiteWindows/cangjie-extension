/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a13_02

  @Level:         1

  @Assertion:    2.3.1(13) The following shows example conversions between Int8 and Int16 using the strategy of
                 throwing exceptions:
                    main() {
                    var i8Number: Int8 = 127
                    var i16Number: Int16 = 0
                    i16Number = Int16(i8Number) // ok: i16Number = 127
                    i8Number = Int8(i16Number) // ok: i8Number = 127
                    i16Number = 128
                    i8Number = Int8(i16Number) // throw an ArithmeticException
                    return 0
                    }

  @Description:  Check exception in example 

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

main() {
    Assert.throws({ =>     
        var i8Number: Int8 = 127
        var i16Number: Int16 = 0
        i16Number = Int16(i8Number) // ok: i16Number = 127
        i8Number = Int8(i16Number) // ok: i8Number = 127
        i16Number = 128
        var a13_02_01 = [i16Number]
        i8Number = Int8(a13_02_01[0]) // throw an ArithmeticException
    }, check: { e => e is ArithmeticException})
    return 0
}