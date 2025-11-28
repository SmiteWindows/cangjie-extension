/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a13_01

  @Level:         1

  @Assertion:    3.3.1(13) The variable type is optional.

  @Description:  Check that immutable variables can be declared w\o type.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

public let myPublicTopVarNotDefinedButInt = 128
public let myPublicTopVarNotDefinedButFloat = 0.13
public let myPublicTopVarNotDefinedButString = "String"
public let myPublicTopVarNotDefinedButChar = 'A'
public let myPublicTopVarNotDefinedButTuple = (12, "aaa", true)

let myTopVarNotDefinedButInt = -16
let myTopVarNotDefinedButFloat = 0.55
let myTopVarNotDefinedButString = "Another string"
let myTopVarNotDefinedButChar = 'V'
let myTopVarNotDefinedButTuple = (74, 'a', 0.25)

enum Week {
    Moday(Bool) | Other(String)
}

class MyClass {
    static public let staticPublicIntVar = 3 
    static public let staticPublicFloatVar = 3.22
    static public let staticPublicStringVar = "string member"
    static public let staticPublicCharVar = 'D'

    public let publicIntVar = 3 
    let intVar = 3 

    public let publicFloatVar = 3.22
    let floatVar = 3.22 

    public let publicStringVar = "string member"
    let stringVar = "string member"

    public let publicCharVar = 'D'
    let charVar = 'D'
}

struct MyTestStruct { 
    // Int members
    static let staticIntVar = 3 
    static public let staticPublicIntVar = 3 
    static private let staticPrivateIntVar = 3 
    public let publicIntVar = 3 
    private let privateIntVar = 3 
    let intVar = 3 

    // Float members
    static let staticFloatVar = 3.22
    static public let staticPublicFloatVar = 3.22
    static private let staticPrivateFloatVar = 3.22
    public let publicFloatVar = 3.22
    private let privateFloatVar = 3.22
    let floatVar = 3.22 

    // String members
    static let staticStringVar = "string member"
    static public let staticPublicStringVar = "string member"
    static private let staticPrivateStringVar = "string member"
    public let publicStringVar = "string member"
    private let privateStringVar = "string member"
    let stringVar = "string member"

    // Rune members
    static let staticCharVar = 'D'
    static public let staticPublicCharVar = 'D'
    static private let staticPrivateCharVar = 'D'
    public let publicCharVar = 'D'
    private let privateCharVar = 'D'
    let charVar = 'D'

    static func checkStaticPrivateValues() {
        Assert.equals(3, staticPrivateIntVar)
        Assert.equals(3.22, staticPrivateFloatVar)

        Assert.equals("string member", staticPrivateStringVar)
        Assert.equals('D', staticPrivateCharVar)
    }

    func checkPrivateValues() {
        Assert.equals(3, privateIntVar)
        Assert.equals(3.22, privateFloatVar)

        Assert.equals("string member", privateStringVar)
        Assert.equals('D', privateCharVar)
    }
} 

main() {
    let myVarNotDefinedButInt = 24
    let myVarNotDefinedButFloat = -1.29
    let myVarNotDefinedButString = "Another string in local-level variable"
    let myVarNotDefinedButChar = 'L'
    let myVarNotDefinedButTuple = ('a', 0.25, false)

    Assert.equals(24, myVarNotDefinedButInt)
    Assert.equals(-1.29, myVarNotDefinedButFloat)

    Assert.equals("Another string in local-level variable", myVarNotDefinedButString)
    Assert.equals('L', myVarNotDefinedButChar)

    let (x0, y0, z0) = myVarNotDefinedButTuple
    Assert.equals('a', x0)
    Assert.equals(0.25, y0)
    Assert.equals(false, z0)

    Assert.equals(128, myPublicTopVarNotDefinedButInt)
    Assert.equals(0.13, myPublicTopVarNotDefinedButFloat)

    Assert.equals("String", myPublicTopVarNotDefinedButString)
    Assert.equals('A', myPublicTopVarNotDefinedButChar)

    let (x1, y1, z1) = myPublicTopVarNotDefinedButTuple
    Assert.equals(12, x1)
    Assert.equals("aaa", y1)
    Assert.equals(true, z1)

    Assert.equals(-16, myTopVarNotDefinedButInt)
    Assert.equals(0.55, myTopVarNotDefinedButFloat)

    Assert.equals("Another string", myTopVarNotDefinedButString)
    Assert.equals('V', myTopVarNotDefinedButChar)

    let (x2, y2, z2) = myTopVarNotDefinedButTuple
    Assert.equals(74, x2)
    Assert.equals('a', y2)
    Assert.equals(0.25, z2)

    Assert.equals(3, MyTestStruct.staticIntVar)
    Assert.equals(3.22, MyTestStruct.staticFloatVar)

    Assert.equals("string member", MyTestStruct.staticStringVar)
    Assert.equals('D', MyTestStruct.staticCharVar)
    Assert.equals(3, MyTestStruct.staticPublicIntVar)
    Assert.equals(3.22, MyTestStruct.staticPublicFloatVar)

    Assert.equals("string member", MyTestStruct.staticPublicStringVar)
    Assert.equals('D', MyTestStruct.staticPublicCharVar)

    MyTestStruct.checkStaticPrivateValues()

    let myTestStructImpl = MyTestStruct()

    Assert.equals(3, myTestStructImpl.intVar)
    Assert.equals(3.22, myTestStructImpl.floatVar)

    Assert.equals("string member", myTestStructImpl.stringVar)
    Assert.equals('D', myTestStructImpl.charVar)

    Assert.equals(3, myTestStructImpl.publicIntVar)
    Assert.equals(3.22, myTestStructImpl.publicFloatVar)

    Assert.equals("string member", myTestStructImpl.publicStringVar)
    Assert.equals('D', myTestStructImpl.publicCharVar)

    myTestStructImpl.checkPrivateValues()

    Assert.equals(3, MyClass.staticPublicIntVar)
    Assert.equals(3.22, MyClass.staticPublicFloatVar)

    Assert.equals("string member", MyClass.staticPublicStringVar)
    Assert.equals('D', MyClass.staticPublicCharVar)

    let aaa = MyClass()

    Assert.equals(3, aaa.publicIntVar)
    Assert.equals(3, aaa.intVar)
    Assert.equals(3.22, aaa.publicFloatVar)
    Assert.equals(3.22, aaa.floatVar)

    Assert.equals("string member", aaa.publicStringVar)
    Assert.equals("string member", aaa.stringVar)
    Assert.equals('D', aaa.publicCharVar)
    Assert.equals('D', aaa.charVar)

    let myEnumLetVar = Week.Other("dd")
}
