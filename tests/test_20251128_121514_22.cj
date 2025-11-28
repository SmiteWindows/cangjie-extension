/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_03_01_a10_01

  @Level:         1

  @Assertion:    2.3.1(10) The grammar for type conversion between numeric types is defined as: 
                    numericTypeConvExpr
                    : numericTypes '(' expression ')'
                    ;
                    
                    numericTypes
                    : 'Int8' | 'Int16' | 'Int32' | 'Int64' | 'IntNative' | 'UInt8' | 'UInt16' | 'UInt32' | 'UInt64' |
                      'UIntNative' | 'Float16' | 'Float32' | 'Float64'
                    ;


  @Description:  Check that the correct grammar for numericTypeConvExpr does not cause errors

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

func foo() { -8991.002 }

class MyClass {
    static var m = 18.02f16
}

main(): Unit {
    let a: Array<Int32> = [45,67,12,67]

    Assert.isTrue(Int8(-89_i32) is Int8)
    Assert.isTrue(Int16(15677_i64) is Int16)
    Assert.isTrue(Int32({ => -111_i8 }()) is Int32)
    Assert.isTrue(Int64(2367369_i32 - 151) is Int64)
    Assert.isTrue(IntNative(foo()) is IntNative)
    Assert.isTrue(UInt8(MyClass.m) is UInt8)
    Assert.isTrue(UInt16(157.234f32) is UInt16)
    Assert.isTrue(UInt32(457_i16 << 1) is UInt32)
    Assert.isTrue(UInt64(a[0] & 1) is UInt64)
    Assert.isTrue(UIntNative(35632.022) is UIntNative)
    Assert.isTrue(Float16(35632.022) is Float16)
    Assert.isTrue(Float32(35632_i32) is Float32)
    Assert.isTrue(Float64(-35_i8) is Float64)
}
