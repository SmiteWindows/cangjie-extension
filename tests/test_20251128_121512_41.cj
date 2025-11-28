/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_09_a04_01

  @Level:         1

  @Assertion:   2.1.9(4) The () outside of the parameter type list is mandatory, in which zero or 
                  multiple types can be included (multiple types are separated by ,).

  @Description: Checks that:
                - function type, declared with the () outside of the parameter 
                  type list and when multiple types are separated by ',', work;
                - function type, declared with the () outside of the empty parameter 
                  type list, work;

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.*

type funcType2 = () -> Float32;

func testFunc1(par1: Int8, par2: String): Int8 {
    return par1;
}

func testFunc2(): Float32 {
    return 1.0f32;
}

main() {
    //Test case 1
    Assert.equals(true, testFunc1 is (Int8, String) -> Int8, 
        reason: """
Test case 1: Function, declared with 2 parameters of type Int8
and String and returning Int8 value, has type different
from '(Int8, String) -> Int8'; 
""");

    //Test case 2
    Assert.equals(true, testFunc2 is funcType2, 
        reason: """
Test case 2: Function, declared without parameters
and returning Float32 value, has type different
from funcType2, which is defined as allias of '() -> Float32'; 
""");

    return 0;
}

