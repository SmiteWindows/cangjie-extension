/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a01_03

  @Level:         1

  @Assertion:   2.1.10(1) The struct type is mutable, in which multiple member 
                variables and member functions can be defined.

  @Description: Checks that the struct type is mutable, namely, reassigning member variable
                of struct of Fucntion type does not cause compilation error and works correctly;

  @Mode:        run
  @Negative:    no
  @Structure:   single

*/

import utils.assert.Assert

type funcType = (Int32) -> Int32;
func function1(param: Int32): Int32 { return param; }
func function2(param: Int32): Int32 { return param + 1; }

struct testStruct {
    var varMember: Int32;
    var funcMember: funcType;
    init(varMember: Int32, funcMember: funcType) {
        this.varMember = varMember;
        this.funcMember = funcMember;
    };
}

main() {
    var testStructVar: testStruct = testStruct(10, function1);
    // Test case 1
    Assert.equals(20, testStructVar.funcMember(20), 
        reason: "Test case 1 FAILED.");

    // Test case 2
    testStructVar.funcMember = function2;
    Assert.equals(21, testStructVar.funcMember(20), 
        reason: "Test case 2 FAILED.");

    return 0;
}

