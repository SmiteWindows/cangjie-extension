/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a24_04

  @Level:         1

  @Assertion:    3.3.1(24)
                 To use keywords as variable names, a pair of backticks ( `)s must be used 
                 (such as `open` and `throw`).

  @Description:  Check that mutable variable can be defined as keyword inside a pair of backticks ( `)
                 Case: Set of 25 keywords - (1-25) in alphabet order

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

public var `as` = 16
public var `break`: Int64 = 2
public var `Bool` = (-4, "Afaf")

var `case` = 7
var `catch`: Int64 = -88
var `class` = (12, "HtH")

class MyClass {
    public var `continue`: Int32 = 12
    public var `Rune`: Int32
    protected var `do`: Float32 = 12.03
    protected var `else`: Int32
    private var `enum`: Rune = r'R'
    private var `extend`: Int32
    var `false`: String = "12segfdx"
    var `finally`: Int32

    MyClass(inVal: Int32) {
        this.`Rune` = inVal
        this.`else` = inVal
        this.`extend` = inVal
        this.`finally` = inVal
    }

    func checkValues(inVal: Int32) {
        Assert.equals(this.`Rune`, inVal)
        Assert.equals(this.`else`, inVal)
        Assert.equals(this.`extend`, inVal)
        Assert.equals(this.`finally`, inVal)

        Assert.equals(12, this.`continue`)
        Assert.equals(12.03, this.`do`)

        Assert.equals(r'R', this.`enum`)
        Assert.equals("12segfdx", this.`false`)
    }
}

func assignAndCheckByCondition(flag: Bool) {
    var `for`: Float32
    if(flag) {
      `for` = 24.13
      Assert.equals(24.13, `for`)
    } else {
      `for` = -9.03
      Assert.equals(-9.03, `for`)
    }
}

main() {
    var `foreign`: Bool = true
    var `from`: Bool = false
    Assert.equals(true, `foreign`)
    Assert.equals(false, `from`)

    assignAndCheckByCondition(`foreign`)
    assignAndCheckByCondition(`from`)

    var `func`: Int64 = 0
    var `Float16`: Int64 = `func`
    Assert.equals(0, `Float16`)

    var `Float32` = 44
    Assert.equals(44, `Float32`)

    var `if` = (0, "AAA")
    var `import` = `if`
    Assert.equals(0, `import`[0])
    Assert.equals("AAA", `import`[1])

    var `in`: Int64
    `in` = -90
    Assert.equals(-90, `in`)

    Assert.equals(16, `as`)
    Assert.equals(2, `break`)
    Assert.equals(-4, `Bool`[0])
    Assert.equals("Afaf", `Bool`[1])
    Assert.equals(7, `case`)
    Assert.equals(-88, `catch`)
    Assert.equals(12, `class`[0])
    Assert.equals("HtH", `class`[1])

    var `init` = MyClass(22)
    `init`.checkValues(22)
}
