/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a02_01

  @Level:         1

  @Assertion:   2.1.9(2) The syntax of function type is:
                 arrowType
                  : parameterTypes '->' type
                  ;
                 parameterTypes
                  : '(' (type (',' type)*)? ')'
                  ;

  @Description: Checks that function types, declared according to syntax above, work;

  @Mode:        run
  @Negative:    no
  @Structure:   single
*/

import utils.assert.*

type funcType1 = () -> Rune;
type funcType3 = () -> Unit;

func testFunc1(): Rune {
    return r'X';
}

func testFunc2(par1: Bool, par2: String): String {
    if (par1) {
        return par2;
    }

    return String.empty;
}

func testFunc3() {
}

func testFunc4(par: Bool): Bool {
        return par;
}

main() {
    //Test case 1
    Assert.equals(true, testFunc1 is funcType1, 
        reason: """
Test case 1: Function, declared without parameters
and returning Rune, has type different
from '() -> Rune'; 
""");

    //Test case 2
    Assert.equals(true, testFunc2 is (Bool, String) -> String, 
        reason: """
Test case 2: Function, declared with 2 parameters of type Bool
and String and returning String value, has type different
from '(Bool, String) -> String'; 
""");

    //Test case 3
    Assert.equals(true, testFunc3 is funcType3, 
        reason: """
Test case 3: Function, declared without parameters
and without returning value, has type different
from '() -> Unit'; 
""");

    //Test case 4
    Assert.equals(true, testFunc4 is (Bool) -> Bool, 
        reason: """
Test case 4: Function, declared with parameter of type Bool
and returning Bool value, has type different
from '(Bool) -> Bool'; 
""");

    return 0;
}

