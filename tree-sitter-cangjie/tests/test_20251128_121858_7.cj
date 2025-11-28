/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a05_02

  @Level:         1

  @Assertion:   2.1.9(5)
                 () -> Int32 // A function type has an empty parameter type list, 
                                and its return value type is 'Int32'.
                 () -> Unit // A function type has an empty parameter type list, 
                               and its return value type is 'Unit'.
                 (Float32) -> Int32 // A function type has one parameter whose type is 'Float32', 
                                       and its return value type is 'Int32'
                 (Int32, Int32, Float32) -> Int32 // A function type has three parameters, 
                                                     and its return value type is 'Int32'
                 (Int32, Int32, Float32) -> (Int32, Int32) // A function type has three parameters, 
                                                              and its return value type is '(Int32, Int32)'
                 (Int32, Int32, Float32) -> Unit // A function type has three parameters, 
                                                    and its return value type is 'Unit'.

  @Description: Checks that:
                - function type '(Float32) -> Int32' works correctly;
                - function type '(Int32, Int32, Float32) -> Int32' works correctly;

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.*

type funcType1 = (Float32) -> Int32;
type funcType2 = (Int32, Int32, Float32) -> Int32;

func testFunc1(par: Float32): Int32 {
    return Int32(par);
}

func testFunc2(par1: Int32, par2: Int32, par3: Float32): Int32 {
    var result: Int32 = Int32(par3);
    if (par1 == par2) {
        result = par1;
    }
    
    return result;
}

main() {
    //Test case 1
    Assert.equals(true, testFunc1 is funcType1, 
        reason: """
Test case 1: Function, declared with 1 parameter (Float32)
and returning Int32 value, has type different
from funcType1, which is defined as allias of '(Float32) -> Int32'; 
""");

    //Test case 2
    let resultOfTestFunc1 = testFunc1(2.0);
    Assert.equals(true, resultOfTestFunc1 is Int32, 
        reason: """
Test case 2: Function of funcType1, which is defined 
as allias of '(Float32) -> Int32',
returns value of type different from Int32; 
""");

    //Test case 3
    Assert.equals(2, resultOfTestFunc1, 
        reason: """
Test case 3: Function of funcType1, which is defined 
as allias of '(Float32) -> Int32',
returns value different from expected; 
""");

    //Test case 4
    Assert.equals(true, testFunc2 is funcType2, 
        reason: """
Test case 4: Function, declared with three parameters
(Int32, Int32, Float32) and returning Int32 value, has type different
from funcType2, which is defined as allias of 
'(Int32, Int32, Float32) -> Int32'; 
""");

    //Test case 5
    let resultOfTestFunc2 = testFunc2(98, 99, 3.0);
    Assert.equals(true, resultOfTestFunc2 is Int32, 
        reason: """
Test case 5: Function of funcType2, which is defined as allias of 
'(Int32, Int32, Float32) -> Int32',
returns value of type different from Int32; 
""");

    //Test case 6
    Assert.equals(3, resultOfTestFunc2, 
        reason: """
Test case 6: Function of funcType2, which is defined as allias of 
'(Int32, Int32, Float32) -> Int32',
returns value different from expected; 
""");

    return 0;
}

