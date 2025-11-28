/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a06_01

  @Level:         1

  @Assertion:   2.1.1(6) Int8 −2^7 ~ 2^7 − 1 (-128 to 127)

  @Description: Checks that variable declared with integer type Int8 can be assigned 
                by minimal and maximal values;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    let intVar01: Int8 = -128;
    Assert.equals(-128, intVar01, 
        reason: """
Test case 1: A variable, declared with type Int8
and assigned by minimal Int8 value, has unexpected value.
""");

    //Test case 2
    let intVar02: Int8 = 127;
    Assert.equals(127, intVar02, 
        reason: """
Test case 2: A variable, declared with type Int8
and assigned by maximal Int8 value, has unexpected value.
""");

    return 0;
}

