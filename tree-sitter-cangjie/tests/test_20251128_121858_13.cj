/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a24_05

  @Level:         1

  @Assertion:    3.3.1(24)  To use keywords as variable names, a pair of backticks ( `)s must be used 
                 (such as `open` and `throw`).

  @Description:  Check that mutable variable can be defined as keyword inside a pair of backticks ( `)
                 Case: Set of 25 keywords - (26-51) in alphabet order

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

public var `interface` = 16
public var `is`: Int64 = 2
public var `Int8` = (-4, "Afaf")

var `Int16` = 7
var `Int32`: Int64 = -88
var `Int64` = (12, "HtH")

class MyClass {
    public var `IntNative`: Int32 = 12
    public var `let`: Int32
    protected var `macro`: Float32 = 12.03
    protected var `match`: Int32
    private var `mut`: Rune = r'R'
    private var `main`: Int32
    var `Nothing`: String = "12segfdx"
    var `operator`: Int32

    MyClass(inVal: Int32) {
        this.`let` = inVal
        this.`match` = inVal
        this.`main` = inVal
        this.`operator` = inVal
    }

    func checkValues(inVal: Int32) {
        Assert.equals(this.`let`, inVal)
        Assert.equals(this.`match`, inVal)
        Assert.equals(this.`main`, inVal)
        Assert.equals(this.`operator`, inVal)

        Assert.equals(12, this.`IntNative`)
        Assert.equals(12.03, this.`macro`)

        Assert.equals(r'R', this.`mut`)
        Assert.equals("12segfdx", this.`Nothing`)
    }
}

func assignAndCheckByCondition(flag: Bool) {
    var `package`: Float32
    if(flag) {
      `package` = 24.13
      Assert.equals(24.13, `package`)
    } else {
      `package` = -9.03
      Assert.equals(-9.03, `package`)
    }
}

main() {
    var `prop`: Bool = true
    var `quote`: Bool = false
    Assert.equals(true, `prop`)
    Assert.equals(false, `quote`)

    assignAndCheckByCondition(`prop`)
    assignAndCheckByCondition(`quote`)

    var `return`: Int64 = 0
    var `spawn`: Int64 = `return`
    Assert.equals(0, `spawn`)

    var `struct` = 44
    Assert.equals(44, `struct`)

    var `static` = (0, "AAA")
    var `super` = `static`
    Assert.equals(0, `super`[0])
    Assert.equals("AAA", `super`[1])

    var `synchronized`: Int64
    `synchronized` = -90
    Assert.equals(-90, `synchronized`)

    Assert.equals(16, `interface`)
    Assert.equals(2, `is`)
    Assert.equals(-4, `Int8`[0])
    Assert.equals("Afaf", `Int8`[1])
    Assert.equals(7, `Int16`)
    Assert.equals(-88, `Int32`)
    Assert.equals(12, `Int64`[0])
    Assert.equals("HtH", `Int64`[1])

    var `this` = MyClass(22)
    `this`.checkValues(22)
}
