/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a15_02

  @Level:         1

  @Assertion:    3.3.1(15) The compiler attempts to infer the variable type based on the initial value.

  @Description:  Check that immutable variables initialized with specific values will be recognised with right type

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

type MyTupleType = (Float64, String)

let tmpInt8: Int8 = 127
let tmpInt16: Int16 = 32767
let tmpInt32: Int32 = 2147483647
let tmpInt64: Int64 = 9223372036854775807
let tmpUInt8: UInt8 = 255
let tmpUInt16: UInt16 = 65535
let tmpUInt32: UInt32 = 4294967295
let tmpUInt64: UInt64 = 18446744073709551615
let tmpFloat16: Float16 = 4.65
let tmpFloat32: Float32 = 17.8
let tmpFloat64: Float64 = 124.12
let tmpChar: Rune = 'U'
let tmpString: String = "HFAg"
let tmpTuple: MyTupleType = (-7.0, "GGG")

public let myPublicTopNotDefinedButUInt8Initialized = tmpUInt8
public let myPublicTopNotDefinedButUInt16Initialized = tmpUInt16
public let myPublicTopNotDefinedButUInt32Initialized = tmpUInt32
public let myPublicTopNotDefinedButUInt64Initialized = tmpUInt64

public let myPublicTopNotDefinedButInt8Initialized = tmpInt8
public let myPublicTopNotDefinedButInt16Initialized = tmpInt16
public let myPublicTopNotDefinedButInt32Initialized = tmpInt32
public let myPublicTopNotDefinedButInt64Initialized = tmpInt64

public let myPublicTopNotDefinedButFloat16Initialized = tmpFloat16
public let myPublicTopNotDefinedButFloat32Initialized = tmpFloat32
public let myPublicTopNotDefinedButFloat64Initialized = tmpFloat64

public let myPublicTopNotDefinedButCharInitialized = tmpChar
public let myPublicTopNotDefinedButStringInitialized = tmpString
public let myPublicTopNotDefinedButTupleInitialized = tmpTuple

let myTopNotDefinedButUInt8Initialized = tmpUInt8
let myTopNotDefinedButUInt16Initialized = tmpUInt16
let myTopNotDefinedButUInt32Initialized = tmpUInt32
let myTopNotDefinedButUInt64Initialized = tmpUInt64

let myTopNotDefinedButInt8Initialized = tmpInt8
let myTopNotDefinedButInt16Initialized = tmpInt16
let myTopNotDefinedButInt32Initialized = tmpInt32
let myTopNotDefinedButInt64Initialized = tmpInt64

let myTopNotDefinedFloat16Initialized = tmpFloat16
let myTopNotDefinedFloat32Initialized = tmpFloat32
let myTopNotDefinedFloat64Initialized = tmpFloat64

let myTopNotDefinedButCharInitialized = tmpChar
let myTopNotDefinedButStringInitialized = tmpString
let myTopNotDefinedButTupleInitialized = tmpTuple

class MyClass {
    public let myPublicClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    public let myPublicClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    public let myPublicClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    public let myPublicClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    public let myPublicClassMemberNotDefinedButInt8Initialized = tmpInt8
    public let myPublicClassMemberNotDefinedButInt16Initialized = tmpInt16
    public let myPublicClassMemberNotDefinedButInt32Initialized = tmpInt32
    public let myPublicClassMemberNotDefinedButInt64Initialized = tmpInt64
    public let myPublicClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    public let myPublicClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    public let myPublicClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    public let myPublicClassMemberNotDefinedButCharInitialized = tmpChar
    public let myPublicClassMemberNotDefinedButStringInitialized = tmpString
    public let myPublicClassMemberNotDefinedButTupleInitialized = tmpTuple

    public static let myPublicStaticClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    public static let myPublicStaticClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    public static let myPublicStaticClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    public static let myPublicStaticClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    public static let myPublicStaticClassMemberNotDefinedButInt8Initialized = tmpInt8
    public static let myPublicStaticClassMemberNotDefinedButInt16Initialized = tmpInt16
    public static let myPublicStaticClassMemberNotDefinedButInt32Initialized = tmpInt32
    public static let myPublicStaticClassMemberNotDefinedButInt64Initialized = tmpInt64
    public static let myPublicStaticClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    public static let myPublicStaticClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    public static let myPublicStaticClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    public static let myPublicStaticClassMemberNotDefinedButCharInitialized = tmpChar
    public static let myPublicStaticClassMemberNotDefinedButStringInitialized = tmpString
    public static let myPublicStaticClassMemberNotDefinedButTupleInitialized = tmpTuple

    private let myPrivateClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    private let myPrivateClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    private let myPrivateClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    private let myPrivateClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    private let myPrivateClassMemberNotDefinedButInt8Initialized = tmpInt8
    private let myPrivateClassMemberNotDefinedButInt16Initialized = tmpInt16
    private let myPrivateClassMemberNotDefinedButInt32Initialized = tmpInt32
    private let myPrivateClassMemberNotDefinedButInt64Initialized = tmpInt64
    private let myPrivateClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    private let myPrivateClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    private let myPrivateClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    private let myPrivateClassMemberNotDefinedButCharInitialized = tmpChar
    private let myPrivateClassMemberNotDefinedButStringInitialized = tmpString
    private let myPrivateClassMemberNotDefinedButTupleInitialized = tmpTuple

    private static let myPrivateStaticClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    private static let myPrivateStaticClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    private static let myPrivateStaticClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    private static let myPrivateStaticClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    private static let myPrivateStaticClassMemberNotDefinedButInt8Initialized = tmpInt8
    private static let myPrivateStaticClassMemberNotDefinedButInt16Initialized = tmpInt16
    private static let myPrivateStaticClassMemberNotDefinedButInt32Initialized = tmpInt32
    private static let myPrivateStaticClassMemberNotDefinedButInt64Initialized = tmpInt64
    private static let myPrivateStaticClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    private static let myPrivateStaticClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    private static let myPrivateStaticClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    private static let myPrivateStaticClassMemberNotDefinedButCharInitialized = tmpChar
    private static let myPrivateStaticClassMemberNotDefinedButStringInitialized = tmpString
    private static let myPrivateStaticClassMemberNotDefinedButTupleInitialized = tmpTuple

    protected let myProtectedClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    protected let myProtectedClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    protected let myProtectedClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    protected let myProtectedClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    protected let myProtectedClassMemberNotDefinedButInt8Initialized = tmpInt8
    protected let myProtectedClassMemberNotDefinedButInt16Initialized = tmpInt16
    protected let myProtectedClassMemberNotDefinedButInt32Initialized = tmpInt32
    protected let myProtectedClassMemberNotDefinedButInt64Initialized = tmpInt64
    protected let myProtectedClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    protected let myProtectedClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    protected let myProtectedClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    protected let myProtectedClassMemberNotDefinedButCharInitialized = tmpChar
    protected let myProtectedClassMemberNotDefinedButStringInitialized = tmpString
    protected let myProtectedClassMemberNotDefinedButTupleInitialized = tmpTuple

    protected static let myProtectedStaticClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    protected static let myProtectedStaticClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    protected static let myProtectedStaticClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    protected static let myProtectedStaticClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    protected static let myProtectedStaticClassMemberNotDefinedButInt8Initialized = tmpInt8
    protected static let myProtectedStaticClassMemberNotDefinedButInt16Initialized = tmpInt16
    protected static let myProtectedStaticClassMemberNotDefinedButInt32Initialized = tmpInt32
    protected static let myProtectedStaticClassMemberNotDefinedButInt64Initialized = tmpInt64
    protected static let myProtectedStaticClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    protected static let myProtectedStaticClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    protected static let myProtectedStaticClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    protected static let myProtectedStaticClassMemberNotDefinedButCharInitialized = tmpChar
    protected static let myProtectedStaticClassMemberNotDefinedButStringInitialized = tmpString
    protected static let myProtectedStaticClassMemberNotDefinedButTupleInitialized = tmpTuple

    let myClassMemberNotDefinedButUInt8Initialized = tmpUInt8
    let myClassMemberNotDefinedButUInt16Initialized = tmpUInt16
    let myClassMemberNotDefinedButUInt32Initialized = tmpUInt32
    let myClassMemberNotDefinedButUInt64Initialized = tmpUInt64
    let myClassMemberNotDefinedButInt8Initialized = tmpInt8
    let myClassMemberNotDefinedButInt16Initialized = tmpInt16
    let myClassMemberNotDefinedButInt32Initialized = tmpInt32
    let myClassMemberNotDefinedButInt64Initialized = tmpInt64
    let myClassMemberNotDefinedButFloat16Initialized = tmpFloat16
    let myClassMemberNotDefinedButFloat32Initialized = tmpFloat32
    let myClassMemberNotDefinedButFloat64Initialized = tmpFloat64
    let myClassMemberNotDefinedButCharInitialized = tmpChar
    let myClassMemberNotDefinedButStringInitialized = tmpString
    let myClassMemberNotDefinedButTupleInitialized = tmpTuple

    MyClass() {}

    func checkType() {
        Assert.isTrue(this.myPublicClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(this.myPublicClassMemberNotDefinedButTupleInitialized is MyTupleType)

        Assert.isTrue(myPublicStaticClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(myPublicStaticClassMemberNotDefinedButTupleInitialized is MyTupleType)
  
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(this.myPrivateClassMemberNotDefinedButTupleInitialized is MyTupleType)

        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(myPrivateStaticClassMemberNotDefinedButTupleInitialized is MyTupleType)
  
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(this.myProtectedClassMemberNotDefinedButTupleInitialized is MyTupleType)

        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(myProtectedStaticClassMemberNotDefinedButTupleInitialized is MyTupleType)

        Assert.isTrue(this.myClassMemberNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(this.myClassMemberNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(this.myClassMemberNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(this.myClassMemberNotDefinedButUInt64Initialized is UInt64)
        Assert.isTrue(this.myClassMemberNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(this.myClassMemberNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(this.myClassMemberNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(this.myClassMemberNotDefinedButInt64Initialized is Int64)
        Assert.isTrue(this.myClassMemberNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(this.myClassMemberNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(this.myClassMemberNotDefinedButFloat64Initialized is Float64)
        Assert.isTrue(this.myClassMemberNotDefinedButCharInitialized is Rune)
        Assert.isTrue(this.myClassMemberNotDefinedButStringInitialized is String)
        Assert.isTrue(this.myClassMemberNotDefinedButTupleInitialized is MyTupleType)
    }
}

struct MyStruct {
    let myStructNotDefinedButUInt8Initialized = tmpUInt8
    let myStructNotDefinedButUInt16Initialized = tmpUInt16
    let myStructNotDefinedButUInt32Initialized = tmpUInt32
    let myStructNotDefinedButUInt64Initialized = tmpUInt64

    let myStructNotDefinedButInt8Initialized = tmpInt8
    let myStructNotDefinedButInt16Initialized = tmpInt16
    let myStructNotDefinedButInt32Initialized = tmpInt32
    let myStructNotDefinedButInt64Initialized = tmpInt64

    let myStructNotDefinedButFloat16Initialized = tmpFloat16
    let myStructNotDefinedButFloat32Initialized = tmpFloat32
    let myStructNotDefinedButFloat64Initialized = tmpFloat64

    let myStructNotDefinedButCharInitialized = tmpChar
    let myStructNotDefinedButStringInitialized = tmpString

    let myStructNotDefinedButTupleInitialized = tmpTuple

    func checkType() {
        Assert.isTrue(myStructNotDefinedButUInt8Initialized is UInt8)
        Assert.isTrue(myStructNotDefinedButUInt16Initialized is UInt16)
        Assert.isTrue(myStructNotDefinedButUInt32Initialized is UInt32)
        Assert.isTrue(myStructNotDefinedButUInt64Initialized is UInt64)
    
        Assert.isTrue(myStructNotDefinedButInt8Initialized is Int8)
        Assert.isTrue(myStructNotDefinedButInt16Initialized is Int16)
        Assert.isTrue(myStructNotDefinedButInt32Initialized is Int32)
        Assert.isTrue(myStructNotDefinedButInt64Initialized is Int64)
    
        Assert.isTrue(myStructNotDefinedButFloat16Initialized is Float16)
        Assert.isTrue(myStructNotDefinedButFloat32Initialized is Float32)
        Assert.isTrue(myStructNotDefinedButFloat64Initialized is Float64)

        Assert.isTrue(myStructNotDefinedButCharInitialized is Rune)
        Assert.isTrue(myStructNotDefinedButStringInitialized is String)

        Assert.isTrue(myStructNotDefinedButTupleInitialized is MyTupleType)
    }
} 

func myFunc() {
    let myLocalFuncNotDefinedButUInt8Initialized = tmpUInt8
    let myLocalFuncNotDefinedButUInt16Initialized = tmpUInt16
    let myLocalFuncNotDefinedButUInt32Initialized = tmpUInt32
    let myLocalFuncNotDefinedButUInt64Initialized = tmpUInt64

    let myLocalFuncNotDefinedButInt8Initialized = tmpInt8
    let myLocalFuncNotDefinedButInt16Initialized = tmpInt16
    let myLocalFuncNotDefinedButInt32Initialized = tmpInt32
    let myLocalFuncNotDefinedButInt64Initialized = tmpInt64

    let myLocalFuncNotDefinedButFloat16Initialized = tmpFloat16
    let myLocalFuncNotDefinedButFloat32Initialized = tmpFloat32
    let myLocalFuncNotDefinedButFloat64Initialized = tmpFloat64

    let myLocalFuncNotDefinedButCharInitialized = tmpChar
    let myLocalFuncNotDefinedButStringInitialized = tmpString

    let myLocalFuncNotDefinedButTupleInitialized = tmpTuple

    Assert.isTrue(myLocalFuncNotDefinedButUInt8Initialized is UInt8)
    Assert.isTrue(myLocalFuncNotDefinedButUInt16Initialized is UInt16)
    Assert.isTrue(myLocalFuncNotDefinedButUInt32Initialized is UInt32)
    Assert.isTrue(myLocalFuncNotDefinedButUInt64Initialized is UInt64)
    
    Assert.isTrue(myLocalFuncNotDefinedButInt8Initialized is Int8)
    Assert.isTrue(myLocalFuncNotDefinedButInt16Initialized is Int16)
    Assert.isTrue(myLocalFuncNotDefinedButInt32Initialized is Int32)
    Assert.isTrue(myLocalFuncNotDefinedButInt64Initialized is Int64)
    
    Assert.isTrue(myLocalFuncNotDefinedButFloat16Initialized is Float16)
    Assert.isTrue(myLocalFuncNotDefinedButFloat32Initialized is Float32)
    Assert.isTrue(myLocalFuncNotDefinedButFloat64Initialized is Float64)

    Assert.isTrue(myLocalFuncNotDefinedButCharInitialized is Rune)
    Assert.isTrue(myLocalFuncNotDefinedButStringInitialized is String)

    Assert.isTrue(myLocalFuncNotDefinedButTupleInitialized is MyTupleType)
}

func assignInt32(): Int32 {
    23
}

func assignRangeInt32(): Range<Int32> {
    1..10:1
}

func assignString() {
    "F"
}

main() {
    myFunc()
    let myLocalNotDefinedInitialized1 = assignInt32()
    Assert.isTrue(myLocalNotDefinedInitialized1 is Int32)
    let myLocalNotDefinedInitialized2 = assignRangeInt32()
    Assert.isTrue(myLocalNotDefinedInitialized2 is Range<Int32>)
    let myLocalNotDefinedInitialized3 = assignString()
    Assert.isTrue(myLocalNotDefinedInitialized3 is String)

    let myLocalNotDefinedInitialized4 = 55i8
    Assert.isTrue(myLocalNotDefinedInitialized4 is Int8)
    let myLocalNotDefinedInitialized5 = 1.5e-2
    Assert.isTrue(myLocalNotDefinedInitialized5 is Float64)

    let lambda1: (Int64, Int64)->Int64 = {a: Int64, b: Int64 => a + b}
    let myLocalNotDefinedInitialized6 = lambda1(12, 8)
    Assert.isTrue(myLocalNotDefinedInitialized6 is Int64)
  
    let myLocalNotDefinedButUInt8Initialized = tmpUInt8
    let myLocalNotDefinedButUInt16Initialized = tmpUInt16
    let myLocalNotDefinedButUInt32Initialized = tmpUInt32
    let myLocalNotDefinedButUInt64Initialized = tmpUInt64

    let myLocalNotDefinedButInt8Initialized = tmpInt8
    let myLocalNotDefinedButInt16Initialized = tmpInt16
    let myLocalNotDefinedButInt32Initialized = tmpInt32
    let myLocalNotDefinedButInt64Initialized = tmpInt64

    let myLocalNotDefinedFloat16Initialized = tmpFloat16
    let myLocalNotDefinedFloat32Initialized = tmpFloat32
    let myLocalNotDefinedFloat64Initialized = tmpFloat64

    let myLocalNotDefinedButCharInitialized = tmpChar
    let myLocalNotDefinedButStringInitialized = tmpString

    let myLocalNotDefinedButTupleInitialized = tmpTuple

    let myClassImpl = MyClass()
    myClassImpl.checkType()

    let myStructImpl = MyStruct()
    myStructImpl.checkType()

    Assert.isTrue(myPublicTopNotDefinedButUInt8Initialized is UInt8)
    Assert.isTrue(myPublicTopNotDefinedButUInt16Initialized is UInt16)
    Assert.isTrue(myPublicTopNotDefinedButUInt32Initialized is UInt32)
    Assert.isTrue(myPublicTopNotDefinedButUInt64Initialized is UInt64)
    
    Assert.isTrue(myPublicTopNotDefinedButInt8Initialized is Int8)
    Assert.isTrue(myPublicTopNotDefinedButInt16Initialized is Int16)
    Assert.isTrue(myPublicTopNotDefinedButInt32Initialized is Int32)
    Assert.isTrue(myPublicTopNotDefinedButInt64Initialized is Int64)
    
    Assert.isTrue(myPublicTopNotDefinedButFloat16Initialized is Float16)
    Assert.isTrue(myPublicTopNotDefinedButFloat32Initialized is Float32)
    Assert.isTrue(myPublicTopNotDefinedButFloat64Initialized is Float64)

    Assert.isTrue(myPublicTopNotDefinedButCharInitialized is Rune)
    Assert.isTrue(myPublicTopNotDefinedButStringInitialized is String)
    Assert.isTrue(myPublicTopNotDefinedButTupleInitialized is MyTupleType)

    Assert.isTrue(myTopNotDefinedButUInt8Initialized is UInt8)
    Assert.isTrue(myTopNotDefinedButUInt16Initialized is UInt16)
    Assert.isTrue(myTopNotDefinedButUInt32Initialized is UInt32)
    Assert.isTrue(myTopNotDefinedButUInt64Initialized is UInt64)

    Assert.isTrue(myTopNotDefinedButInt8Initialized is Int8)
    Assert.isTrue(myTopNotDefinedButInt16Initialized is Int16)
    Assert.isTrue(myTopNotDefinedButInt32Initialized is Int32)
    Assert.isTrue(myTopNotDefinedButInt64Initialized is Int64)

    Assert.isTrue(myTopNotDefinedFloat16Initialized is Float16)
    Assert.isTrue(myTopNotDefinedFloat32Initialized is Float32)
    Assert.isTrue(myTopNotDefinedFloat64Initialized is Float64)

    Assert.isTrue(myTopNotDefinedButCharInitialized is Rune)
    Assert.isTrue(myTopNotDefinedButStringInitialized is String)
    Assert.isTrue(myTopNotDefinedButTupleInitialized is MyTupleType)
 
    Assert.isTrue(myLocalNotDefinedButUInt8Initialized is UInt8)
    Assert.isTrue(myLocalNotDefinedButUInt16Initialized is UInt16)
    Assert.isTrue(myLocalNotDefinedButUInt32Initialized is UInt32)
    Assert.isTrue(myLocalNotDefinedButUInt64Initialized is UInt64)

    Assert.isTrue(myLocalNotDefinedButInt8Initialized is Int8)
    Assert.isTrue(myLocalNotDefinedButInt16Initialized is Int16)
    Assert.isTrue(myLocalNotDefinedButInt32Initialized is Int32)
    Assert.isTrue(myLocalNotDefinedButInt64Initialized is Int64)

    Assert.isTrue(myLocalNotDefinedFloat16Initialized is Float16)
    Assert.isTrue(myLocalNotDefinedFloat32Initialized is Float32)
    Assert.isTrue(myLocalNotDefinedFloat64Initialized is Float64)

    Assert.isTrue(myLocalNotDefinedButCharInitialized is Rune)
    Assert.isTrue(myLocalNotDefinedButStringInitialized is String)

    Assert.isTrue(myLocalNotDefinedButTupleInitialized is MyTupleType)
}
