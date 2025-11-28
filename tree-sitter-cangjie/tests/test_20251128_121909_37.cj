/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a06_003

  @Level:         1

  @Assertion:    2(6) The reference types include class type and interface type.

  @Description:  Checks that: 
                 - Function member of source variable of type 'TestInterface' 
                   returnss expected value;
                 - variable, initialized with the value of another source variable of type 'interface',
                   has the same type 'interface';
                 - Function member of variable, when this variable was initialized by the value of 
                   another source variable of type 'interface', returnss expected value;
                 - Function member of source variable of type 'interface' 
                   returns expected value after source variable was modified.
                 - type 'interface' actualy is 'reference type';

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

interface TestInterface {
    func interfaceFunc(): Int32;
};

class TestClass <: TestInterface {
    public var testClassMember: Int32;
    public func interfaceFunc(): Int32 { return testClassMember };

    public TestClass(param: Int32)
    {
        this.testClassMember = param;
    }
};


main() {
//Test_case_1
    var testClassVar = TestClass(100);
    var sourceVar: TestInterface = testClassVar;
    let func_result = sourceVar.interfaceFunc();
    Assert.equals(100, func_result, 
        reason:"""
Test_case_1: Function member of source variable of type 'TestInterface' 
returnss unexpected value.
""");

//Test_case_2
    var targetVar = sourceVar;
    let isExpectedType: Bool = targetVar is TestInterface;
    Assert.equals(true, isExpectedType, 
        reason:"""
Test_case_2: A variable, initialized with the value of 
another source variable of type 'TestInterface', 
has unexpected type.
""");

//Test_case_3
    Assert.equals(100, targetVar.interfaceFunc(), 
        reason:"""
Test_case_3: Function member of variable, initialized by the value of 
another source variable of type 'TestInterface', 
returnss unexpected value.
""");

//Test_case_4
    testClassVar.testClassMember = 200;
    Assert.equals(200, sourceVar.interfaceFunc(), 
        reason:"""
Test_case_4: Function member of source variable of type 'TestInterface' 
returns unexpected value after source variable was modified.
""");

//Test_case_5
    Assert.equals(200, targetVar.interfaceFunc(), 
        reason:"""
Test_case_5: Function member of variable, when this variable was 
initialized by the value of another source variable of 
type 'TestInterface', returns value different from the value, returned by  
the same Function member of the source variable,
when source variable has been modified.
It should not happen for 'reference type': interface.
""");

    return 0;
}

