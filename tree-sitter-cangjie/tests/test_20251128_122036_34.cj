/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a01_02

  @Level:         1

  @Assertion:   2.1.9(1) The function type is immutable and is the type of functions.

  @Description: Checks that some declared functions have 'function type';

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.*

type funcType1 = (Int16) -> Int16;
type funcType2 = (String, String) -> Bool;


func testFunc1(param: Int16): Int16 {
    return param + 1;
}

func testFunc2(s1: String, s2: String): Bool {
    return s1 == s2;
}

main() {
    //Test case 1
    Assert.equals(true, testFunc1 is funcType1, 
        reason: """
Test case 1: Function, declared with parameter of type Int16
and returning Int16 value, has type different
from '(Int16) -> Int16'; 
""");

    //Test case 2
    Assert.equals(true, testFunc1 is (Int16) -> Int16, 
        reason: """
Test case 2: Function, declared with parameter of type Int16
and returning Int16 value, has type different
from '(Int16) -> Int16'; 
""");

    //Test case 3
    Assert.equals(true, testFunc2 is funcType2, 
        reason: """
Test case 3: Function, declared with 2 parameters of type String
and returning Bool value, has type different
from '(String, String) -> Bool'; 
""");

    //Test case 4
    Assert.equals(true, testFunc2 is (String, String) -> Bool, 
        reason: """
Test case 4: Function, declared with 2 parameters of type String
and returning Bool value, has type different
from '(String, String) -> Bool'; 
""");

    return 0;
}

