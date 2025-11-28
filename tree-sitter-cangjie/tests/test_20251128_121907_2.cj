/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a05_01

  @Level:         1

  @Assertion:    3.2.3.2(5) If the name of the local variable is the same as an entities defined in an upper-level
                  scope, the upper-level entity is shadowed whenever the local variable is accessible.

  @Description:  Checks that the upper-level entity is shadowed whenever the local variable is accessible.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

class Test {
    let test : Int32 = 0
    func foo() : Int32 {
        let test : Int32 = 1
        return test
    }    
}

main() {
// test case #1
    let tmp1 : Int32 = 0
    if (tmp1 == 0) {
        Assert.equals(0, tmp1)
        let tmp1 : Int32 = 1
        Assert.equals(1, tmp1)
    }

// test case #2
    var tmp2 : Int32 = 0
    do {
        if (tmp2 > 1) {
            let tmp2 : Int32 = 1
            Assert.equals(1, tmp2)
        } else {
            let tmp2 : Int32 = 2
            Assert.equals(2, tmp2)
        }
        tmp2++
    } while (tmp2 < 2)

// test case #3
    var tmp3 : Float32 = 0.0
    do {
        if (tmp3 > 1.0) {
            let tmp3 : Float32 = 1.0
            Assert.equals(1.0, tmp3)
        } else {
            let tmp3 : String = "bla-bla"
            Assert.equals("bla-bla", tmp3)
        }
        tmp3 = tmp3 + 1.0
    } while (tmp3 < 2.0)

// test case #4
    let tmp4 : String = ""
    func foo4() {
        Assert.equals("", tmp4)
        let tmp4 : Bool = true;
        Assert.equals(true, tmp4)
    }

    foo4()

// test case #5
    let tmp5 : Int64 = 0
    let ss5 : String = match (0) {
        case 1 => "1"
        case 2 => "2"
        case 0 => "0"
        case _ => "-1"
    }

    if (ss5 == "0") {
        let tmp5 = -1
        Assert.equals(-1, tmp5)
    }
 
// test case #6
    let tmp6 : String = ""
    let intArray: Array<Int32> = [0, 1, 2, 3, 4]
    for (item in intArray) {
        Assert.equals("", tmp6)
        let tmp6 : Int32 = item
        Assert.equals(item, tmp6)
    }

// test case #7
    var tmp7 : Int32 = 0
    while (tmp7 < 1) {
        Assert.equals(0, tmp7) 
        tmp7++
        var tmp7 : Int32 = tmp7; 
        if (tmp7 > 0) {
           Assert.equals(1, tmp7) 
        }
    }

// test case #8
    var tmp8 : Int32 = 0
    do {
        Assert.equals(0, tmp8)
        var tmp8 : Int32 = tmp8 + 1; 
        Assert.equals(1, tmp8)
    } while (false)

// test case #9
    Assert.equals(1, Test().foo())
}
