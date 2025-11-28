
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*

  @Name:         03_02_01_a01_01

  @Level:         1

  @Assertion:    3.2.1(1) In Cangjie, an optional sequence of expressions and declarations with the 
                 enclosing pair of curly brackets form a block.

  @Description:  Check that various pairs of curly brackets form blocks.
  
  @Mode:         run

  @Negative:     no

  @Structure:    single


*/

import utils.assert.Assert

func myBoolFunc(i: Int64){
    if(i > 0){
        return false
    }
    return true
}

// Function body is an empty block
func foo01(a: Int64): Unit { }	

// Function body is a non-empty block
func foo02(a: Int32, b: Int32): Int32 { 
    let c : Int32 = 100
    var d : Int32 = (a + b) * c 
    return d
}

// Function body is a sequence of expressions and declarations
func foo03(a: Int32, b: Int32): Int32 { 
    let c : Int32 = 100
    var d : Int32 = (a + b) * c 
    d += c
    return d
}

main() {

//Test-case 1: Check that empty pair of curly brackets forms an empty block

    var res01 = foo01(0)
    Assert.isTrue(res01 is Unit)

//Test-case 2: Check that non-empty sequences of declarations with the enclosing pair of curly brackets form a block

    var res02 : Int32 = foo02(1, 2)
    Assert.equals(300, res02)

//Test-case 3: Check that non-empty sequences of expressions and declarations with the enclosing pair 
//of curly brackets form a block 

    var res03 : Int32 = foo03(3, 4)
    Assert.equals(800, res03)

//Test-case 4: Check that a non-empty sequence of expressions and declarations with the enclosing pair 
//of curly brackets in a if_then forms a block 

    var value04 : Int32  = 10
    var NPlaces : Int32 = 10

    if (myBoolFunc(0)) {
        var NPlaces : Int32 = value04 / 2
    }
    else {
        var NPlaces : Int32 = value04 / 2 + 1
    }
    Assert.equals(10, NPlaces )

//Test-case 5: Check that the enclosing pair of curly brackets in an internal function forms a block 

    var value05 : Int32  = -100

    func foo05(a: Int32, b: Int32): Int32 { 
        let c : Int32 = 50
        var d : Int32 = (a + b) * c 
        d += c
        return d
    }
    var res05 : Int32 = foo05(value05, 100)
    Assert.equals(50, res05)
}   //main


