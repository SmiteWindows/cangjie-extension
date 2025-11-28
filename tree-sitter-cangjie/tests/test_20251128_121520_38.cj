/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_01_a03_01

  @Level:         1

  @Assertion:   2.1.10.1(3) For any member variable, only initialized member variables defined 
                            before it and static member functions can be referenced in its default value expression.

  @Description: Checks that member variable having its default value expression, defined as below, works correctly:
                - expression references to initialized member variable defined before it;
                - expression references to static member function;
                - expression references to both initialized member variable defined before it
                  and static member function;

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.Assert

struct MyStruct1 {
    var var1: String = "s1";
    var var2: String = var1 + "_s2";
}

struct MyStruct2 {
    var var1: String = f() + "_s2";
    static func f(): String { return "s1"; }
}

struct MyStruct3 {
    var var1: String = "s1";
    var var2: String = var1 + "_" + f() + "_s3";
    static func f(): String { return "s2"; }
}

main() {
    // Test case 1
    var myStruct1Var: MyStruct1 = MyStruct1();
    Assert.equals("s1_s2", myStruct1Var.var2, 
        reason: "Test case 1 FAILED.");

    // Test case 2
    var myStruct2Var: MyStruct2 = MyStruct2();
    Assert.equals("s1_s2", myStruct2Var.var1, 
        reason: "Test case 2 FAILED.");

    // Test case 3
    var myStruct3Var: MyStruct3 = MyStruct3();
    Assert.equals("s1_s2_s3", myStruct3Var.var2, 
        reason: "Test case 3 FAILED.");

    return 0;
}


