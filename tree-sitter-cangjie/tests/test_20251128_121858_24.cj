/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a17_02

  @Level:         1

  @Assertion:    3.3.1(17) When the variable type is specified, a colon ( :) must be used between the pattern and the
                 type. Otherwise, the type is inferred by the compiler.

  @Description:  Check that variables defined with a variable type will get a right type

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

public var myPublicTopVarInt16: Int16 = 127
var myTopVarInt32: Int32 = 126
public let myPublicTopLetInt32: Int32 = 55
let myTopLetInt16: Int16 = 126

class MyClass {
    static public var myStaticPublicClassMemberVarInt8: Int8 = 7
    public var myPublicClassMemberVarInt32: Int32 = 12
    static private var myStaticPrivateClassMemberVarInt16: Int16 = 27
    private var myPrivateClassMemberVarInt64: Int64 = 127
    static protected var myStaticProtectedClassMemberVarUInt8: UInt8 = 37
    protected var myProtectedClassMemberVarUInt16: UInt16 = 127
    static var myStaticClassMemberVarUInt32: UInt32 = 127
    var myClassMemberVarUInt64: UInt64 = 127
    static public let myStaticPublicClassMemberLetFloat16: Float16 = 7.0
    public let myPublicClassMemberLetFloat32: Float32 = 17.01
    static private let myStaticPrivateClassMemberLetFloat64: Float64 = 127.0
    private let myPrivateClassMemberLetChar: Rune = 'A'
    static protected let myStaticProtectedClassMemberLetString: String = "127"
    protected let myProtectedClassMemberLetInt32: Int32 = 127
    static let myStaticClassMemberLetInt32: Int32 = 127
    let myClassMemberLetInt32: Int32 = 127

    MyClass() {}

    func checkTypes() {
        Assert.isTrue(myStaticPublicClassMemberVarInt8 is Int8)
        Assert.isTrue(myPublicClassMemberVarInt32 is Int32)
        Assert.isTrue(myStaticPrivateClassMemberVarInt16 is Int16)
        Assert.isTrue(myPrivateClassMemberVarInt64 is Int64)
        Assert.isTrue(myStaticProtectedClassMemberVarUInt8 is UInt8)
        Assert.isTrue(myProtectedClassMemberVarUInt16 is UInt16)
        Assert.isTrue(myStaticClassMemberVarUInt32 is UInt32)
        Assert.isTrue(myClassMemberVarUInt64 is UInt64)
        Assert.isTrue(myStaticPublicClassMemberLetFloat16 is Float16)
        Assert.isTrue(myPublicClassMemberLetFloat32 is Float32)
        Assert.isTrue(myStaticPrivateClassMemberLetFloat64 is Float64)
        Assert.isTrue(myPrivateClassMemberLetChar is Rune)
        Assert.isTrue(myStaticProtectedClassMemberLetString is String)
        Assert.isTrue(myProtectedClassMemberLetInt32 is Int32)
        Assert.isTrue(myStaticClassMemberLetInt32 is Int32)
        Assert.isTrue(myClassMemberLetInt32 is Int32)
    }
}

struct Triangle { 
    static var myStaticVar: Int8 = 10 
    static public var myStaticPublicVar: Int16 = 10 
    public var myPublicVar: Int32 = 10 
    public var myPublicVarNotinitialized: Int32
    var myVar: Int64 = 10 
    var myVarNotinitialized: Int64
    static let myStaticLet: Float16 = 10.0 
    static public let myStaticPublicLet: UInt32 = 10 
    public let myPublicLet: Rune = 'A' 
    public let myPublicLetNotInitialized: Rune
    let myLet: String = "10" 
    let myLetNotInitialized: String

    Triangle() {
        myPublicVarNotinitialized = 68
        myVarNotinitialized = 75
        myPublicLetNotInitialized = 'D'
        myLetNotInitialized = "10" 
    }
} 

main() {
    var myLocalVarInt32: Int32 = 12
    let myLocalLetInt32: Int32 = 12

    Assert.isTrue(myLocalVarInt32 is Int32)
    Assert.isTrue(myLocalVarInt32 is Int32)

    Assert.isTrue(myPublicTopVarInt16 is Int16)
    Assert.isTrue(myTopVarInt32 is Int32)
    Assert.isTrue(myPublicTopLetInt32 is Int32)
    Assert.isTrue(myTopLetInt16 is Int16)

    let myClassImpl = MyClass()
    myClassImpl.checkTypes()

    Assert.isTrue(Triangle.myStaticVar is Int8)
    Assert.isTrue(Triangle.myStaticPublicVar is Int16)
    Assert.isTrue(Triangle.myStaticLet is Float16)
    Assert.isTrue(Triangle.myStaticPublicLet is UInt32)

    var myTriangle = Triangle()
    Assert.isTrue(myTriangle.myPublicLet is Rune)
    Assert.isTrue(myTriangle.myLet is String)
    Assert.isTrue(myTriangle.myPublicVar is Int32)
    Assert.isTrue(myTriangle.myVar is Int64)
    Assert.isTrue(myTriangle.myPublicVarNotinitialized is Int32)
    Assert.isTrue(myTriangle.myVarNotinitialized is Int64)
    Assert.isTrue(myTriangle.myPublicLetNotInitialized is Rune)
    Assert.isTrue(myTriangle.myLetNotInitialized is String)
}
