/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_01_a07_01

  @Level:         1

  @Assertion:   2.1.1(7) Int16 −2^15 ~ 2^15 − 1 (-32768 to 32767)

  @Description: Checks that variable declared with integer type Int16 can be assigned 
                by minimal and maximal values;

  @Mode:        run

  @Negative:    no

  @Structure:   single

*/

import utils.assert.Assert

main() {
    //Test case 1
    let intVar01: Int16 = -32768;
    Assert.equals(-32768, intVar01, 
        reason: """
Test case 1: A variable, declared with type Int16
and assigned by minimal Int16 value, has unexpected value.
""");

    //Test case 2
    let intVar02: Int16 = 32767;
    Assert.equals(32767, intVar02, 
        reason: """
Test case 2: A variable, declared with type Int16
and assigned by maximal Int16 value, has unexpected value.
""");

    return 0;
}

