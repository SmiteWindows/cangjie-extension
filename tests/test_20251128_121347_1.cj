/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a24_06

  @Level:         1

  @Assertion:    3.3.1(24)  To use keywords as variable names, a pair of backticks ( `)s must be used 
                 (such as `open` and `throw`).

  @Description:  Check that mutable variable can be defined as keyword inside a pair of backticks ( `)
                 Case: Set of 25 keywords - (52-73) in alphabet order

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

public var `throw` = 16
public var `true`: Int64 = 2
public var `try` = (-4, "Afaf")

var `type` = 7
var `This`: Int64 = -88
var `unsafe` = (12, "HtH")

class MyClass {
    public var `UInt8`: Int32 = 12
    public var `UInt16`: Int32
    protected var `UInt32`: Float32 = 12.03
    protected var `UInt64`: Int32
    private var `UIntNative`: Rune = r'R'
    private var `Unit`: Int32
    var `var`: String = "12segfdx"
    var `where`: Int32

    MyClass(inVal: Int32) {
        this.`UInt16` = inVal
        this.`UInt64` = inVal
        this.`Unit` = inVal
        this.`where` = inVal
    }

    func checkValues(inVal: Int32) {
        Assert.equals(this.`UInt16`, inVal)
        Assert.equals(this.`UInt64`, inVal)
        Assert.equals(this.`Unit`, inVal)
        Assert.equals(this.`where`, inVal)

        Assert.equals(12, this.`UInt8`)
        Assert.equals(12.03, this.`UInt32`)

        Assert.equals(r'R', this.`UIntNative`)
        Assert.equals("12segfdx", this.`var`)
    }
}

func assignAndCheckByCondition(flag: Bool) {
    var `while`: Float32
    if(flag) {
      `while` = 24.13
      Assert.equals(24.13, `while`)
    } else {
      `while` = -9.03
      Assert.equals(-9.03, `while`)
    }
}

main() {
    var `abstract`: Bool = true
    var `open`: Bool = false
    Assert.equals(true, `abstract`)
    Assert.equals(false, `open`)

    assignAndCheckByCondition(`abstract`)
    assignAndCheckByCondition(`open`)

    var `override`: Int64 = 0
    var `private`: Int64 = `override`
    Assert.equals(0, `private`)

    var `protected` = 44
    Assert.equals(44, `protected`)

    var `public` = (0, "AAA")
    var `redef` = `public`
    Assert.equals(0, `redef`[0])
    Assert.equals("AAA", `redef`[1])

    var `get`: Int64
    `get` = -90
    Assert.equals(-90, `get`)

    Assert.equals(16, `throw`)
    Assert.equals(2, `true`)
    Assert.equals(-4, `try`[0])
    Assert.equals("Afaf", `try`[1])
    Assert.equals(7, `type`)
    Assert.equals(-88, `This`)
    Assert.equals(12, `unsafe`[0])
    Assert.equals("HtH", `unsafe`[1])

    var `set` = MyClass(22)
    `set`.checkValues(22)
}
