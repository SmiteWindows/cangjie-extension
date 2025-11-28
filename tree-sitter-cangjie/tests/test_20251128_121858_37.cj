/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_01_a02_01

  @Level:         1

  @Assertion:    3.2.1(2) Blocks are pervasive; for example, the bodies of function definitions, 
                 the two branches of if expressions, and the bodies of while loops are all blocks.

  @Description:  Check that the bodies of function definitions are blocks.

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

func foo01(a: Int64, b: Int64) : Int64 { 
    var y01 : Int64 = (a + b) * 10
    y01++
    return y01
}    
    
func foo02(a: Int64) { 
    var y02 : Int64 = a * 10
    y02 += 1
}    

func foo03(): Unit { }

    
main() {

//  Test-case 1: consider blocks in a function body with return (new scopes)

    var y01: Int64 = 100
    var b : Int64 = -100
    y01 = foo01(y01, b)
    Assert.equals(1, y01)

//  Test-case 2: consider blocks in a function body w/o return (new scopes)

    let x02 = 100
    var y02 : Int64 = 2 * x02
    foo02(x02)
    Assert.equals(200, y02)

//  Test-case 3: function body can be an empty block
    
    var y03 = foo03()
    Assert.isTrue(y03 is Unit)

//  Test-case 4: consider blocks in internal function body

    func foo04(a: Int32) : Int32 { 
        var y04 : Int32 = (a + 10) * 10
        y04 
    }    
    var x04 : Int32 = -10
    var y04 : Int32 = foo04(x04)
    Assert.equals(0, y04)

//  Test-case 5: blocks in function bodies can be nested

    func foo05(a: Int32, temp: Int32) : Int32 { 
        var y05 : Int32 = -1
        if (temp > 0) {
            y05 = a + 2 * temp
        }
        else {
            y05 =  a - 2 * temp
        } 
        y05   
    }
    let x05 : Int32 = -10
    var y05 : Int32 = 10
    y05 = foo05(x05, 5)
    Assert.equals(0, y05)
}   //main

