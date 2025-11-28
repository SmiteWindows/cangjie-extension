/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_02_a04_02

  @Level:         1

  @Assertion:    1.2(4) A newline character may appear between any two tokens.

  @Description:  Using the newline character as a separator for different cases of declarations.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @CompileWarning: Ignore

*/

import utils.assert.Assert

func foo<T>(a : T, b : T): T { return b }
main() {
    // test case #1
    var v1 : Float64 = 0.0
    v1 =
    1.0
    /
    2.0
    *
    4.0
    
    // test case #2
    var v2 : Int32 = 9
    v2 =
    v2
    +
    1
    >>
    1
    
    // test case #3
    func add(a : Int32, b : Int32) { return a + b }
    let v3 =
    add(
    (
    1
    +
    2
    )
    /
    3
    << 1
    ,
    (
    2
    +
    4
    )
    /
    3
    <<
    1
    )
    
    // test case #4
    let v4 = foo<Int32>(
    (
    1
    +
    2
    )
    /
    3
    *
    2
    ,
    
    (
    2
    +
    4
    )
    /
    3
    *
    4
    )
    
    // test case #5
    let v5 = foo<Float64>(
    (
    1.0
    +
    2.0
    )
    /
    3.0
    *
    2.0
    ,
    
    (
    2.0
    +
    4.0
    )
    /
    3.0
    *
    4.0
    )
    
    // test case #6
    let v6 = foo<String>(
    "argument #1"
    ,
    
    "argument #2"
    )
    
    // test case #7
    let v7 = foo<Float64>(
    (
    1.0
    +
    0.11
    )
    **
    2
    ,
    
    (
    2.0
    +
    1.11
    )
    **
    2
    )
    
    // test case #8
    let arg : Float64 =
    3.11
    **
    2
    
    let v8 = foo<Float64>(
    1.11
    **
    2
    ,
    
    arg
    )
    
    Assert.equals(arg, v8)
    Assert.equals(3.11 ** 2, v8)
    Assert.equals(2.000000, v1) 	     // test case #1
    Assert.equals(5, v2)	    	     // test case #2
    Assert.equals(6, v3)	    	     // test case #3
    Assert.equals(8, v4)        	     // test case #4
    Assert.equals(8.000000, v5)  	     // test case #5
    Assert.equals("argument #2", v6)     // test case #6
    Assert.equals((2.0 + 1.11) ** 2, v7) // test case #7
    Assert.equals(arg, v8)               // test case #8
}