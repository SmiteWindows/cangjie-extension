/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a06_002

  @Level:         1

  @Assertion:    2(6) The reference types include class type and interface type.

  @Description:  Checks that: 
                 - source variable, initialized with the value of type 'class', has the expected type;
                 - source variable, initialized with the value of type 'class', has the expected value
                   of one their member;
                 - variable, initialized with the value of another source variable of type 'class',
                   has the same type 'class';
                 - variable, initialized with the value of another source variable of type 'class',
                   has expected value of one their member, the same as source variable;
                 - source variable of type 'class' has new corrrect value of one their member
                   after that member was reassigned;
                 - type 'class' actualy is 'reference type';

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

class TestClass {
    var testClassVar_01: Int32;
    var testClassVar_02: UInt32;
    public TestClass(var_01: Int32, var_02: UInt32)
    {
        this.testClassVar_01 = var_01;
        this.testClassVar_02 = var_02;
    }
};

main() {
//Test_case_1
    let sourceVar = TestClass(-100, 100);
    let isExpectedType_01 = sourceVar is TestClass;
    Assert.equals(true, isExpectedType_01, 
        reason:"""
Test_case_1: Source variable, initialized with the constructor of 'TestClass', 
has the unexpected type.
""");

//Test_case_2
    Assert.equals(-100, sourceVar.testClassVar_01, 
        reason:"""
Test_case_2: Source variable of type 'TestClass', initialized with the constructor, 
has the unexpected value of one their member.
""");

//Test_case_3
    var targetVar = sourceVar;
    let isExpectedType_02: Bool = targetVar is TestClass;
    Assert.equals(true, isExpectedType_02, 
        reason:"""
Test_case_3: A variable, initialized with the value of 
another source variable of type 'TestClass', 
has unexpected type.
""");


//Test_case_4
    Assert.equals(100, targetVar.testClassVar_02, 
        reason:"""
Test_case_4: A variable, initialized by the value of 
another source variable of type 'TestClass', 
has the unexpected value of one their member.
""");

//Test_case_5
    sourceVar.testClassVar_01 = 99;
    Assert.equals(99, sourceVar.testClassVar_01, 
        reason:"""
Test_case_5: Source variable of type 'TestClass' 
has unexpected value of one their member after that member was reassigned.
""");


//Test_case_6
    Assert.equals(99, targetVar.testClassVar_01, 
        reason:"""
Test_case_6: A variable, initialized by the value 
of another source variable of type 'TestClass', 
has value of one their member different from the value 
of the same member of the source variable
when that member of source variable has been reaasigned.
It should not happen for 'reference type': class.
""");

    return 0;
}

