/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a12_02

  @Level:         1

  @Assertion:    3.3.1(12) When defining member variables in classes and structs, 
                 only the binding pattern can be used (see Binding Patterns).

  @Description:  Check that class member variables can be defined using binding pattern.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

class MyClass{
    public let letPublicInitialisedInt8: Int8 = 5
    public let letPublicNotInitialisedInt16: Int16
    public var varPublicInitialisedInt32: Int32 = 12
    public var varPublicNotInitialisedFloat16: Float16
    protected let letProtectedInitialisedFloat32: Float32 = 12.5
    protected let letProtectedNotInitialisedFloat64: Float64
    protected var varProtectedInitialisedUInt8: UInt8 = 1
    protected var varProtectedNotInitialisedUInt32: UInt32
    private let letPrivateInitialisedUInt64: UInt32 = 12
    private let letPrivateNotInitialisedString: String
    private var varPrivateInitialisedChar: Rune = r'G'
    private var varPrivateNotInitialised = 17.9
    let letInitialised = "12"
    let letNotInitialised: Rune
    var varInitialised = ("AAA", 8)
    var varNotInitialisedInt32: Int32

    MyClass() {
        this.letPublicNotInitialisedInt16 = -6
        this.varPublicNotInitialisedFloat16 = 18.0
        this.letProtectedNotInitialisedFloat64 = -12.033
        this.varProtectedNotInitialisedUInt32 = 9
        this.letPrivateNotInitialisedString = "sadfds"
        this.letNotInitialised = r'H'
        this.varNotInitialisedInt32 = 8
    }

    func checkNonPublic() {
        Assert.equals(12.5, this.letProtectedInitialisedFloat32)
        Assert.equals(-12.033, this.letProtectedNotInitialisedFloat64)
        Assert.equals(1, this.varProtectedInitialisedUInt8)
        Assert.equals(9, this.varProtectedNotInitialisedUInt32)
        Assert.equals(12, this.letPrivateInitialisedUInt64)

        Assert.equals("sadfds", this.letPrivateNotInitialisedString)
        Assert.equals(r'G', this.varPrivateInitialisedChar)

        Assert.equals(17.9, this.varPrivateNotInitialised)
    }
}

main() {
    let myClassImpl = MyClass()

    Assert.equals(5, myClassImpl.letPublicInitialisedInt8)
    Assert.equals(-6, myClassImpl.letPublicNotInitialisedInt16)
    Assert.equals(12, myClassImpl.varPublicInitialisedInt32)
    Assert.equals(18.0, myClassImpl.varPublicNotInitialisedFloat16)

    Assert.equals("12", myClassImpl.letInitialised)
    Assert.equals(r'H', myClassImpl.letNotInitialised)

    Assert.equals(8, myClassImpl.varNotInitialisedInt32)
    var (tmpX, tmpY) = myClassImpl.varInitialised
    Assert.equals("AAA", tmpX)
    Assert.equals(8, tmpY)

    myClassImpl.checkNonPublic()
}