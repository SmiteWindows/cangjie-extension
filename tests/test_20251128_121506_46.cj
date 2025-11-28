/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a03_01

  @Level:         1

  @Assertion:   2.1.9(3) The parameter type list (i.e., parameterTypes) and the return value type 
                  (i.e., type) are linked using ->.


  @Description: Checks that function types, declared with using '->' as link
                between parameter type list and returned value type, work;

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.*

type funcType = (Int8, String) -> Int8;

func testFunc(par1: Int8, par2: String): Int8 {
    if (par2.isEmpty()) {
        return par1;
    }

    return 0;
}

main() {
    //Test case 1
    Assert.equals(true, testFunc is (Int8, String) -> Int8, 
        reason: """
Test case 1: Function, declared with 2 parameters of type Int8
and String and returning Int8 value, has type different
from '(Int8, String) -> Int8'; 
""");

    //Test case 2
    Assert.equals(true, testFunc is funcType, 
        reason: """
Test case 2: Function, declared with 2 parameters of type Int8
and String and returning Int8 value, has type different
from funcType, which is defined as allias of '(Int8, String) -> Int8'; 
""");

    return 0;
}

