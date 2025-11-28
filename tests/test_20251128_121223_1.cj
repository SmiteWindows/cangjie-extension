/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a05_020

  @Level:         1

  @Assertion:    2(5) The value types include numeric types (include integer types and 
                 floating-point types, see Numeric Types), Rune type, Bool type, 
                 Unit type, Nothing type, String type, Tuple type, Range type, 
                 Function type, struct type, enum type and VArray type. 

  @Description:  Checks that: 
                 -Function, declared with parameter of type 'Function', 
                  works correctly, when Function parameter is passed as name of function
                  or as variable of type 'Function'.
                 - variable, initialized with the value of another source variable of type 'Function',
                   has the same type 'Function';
                 - type 'Function' actualy is 'value type';

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

type test_func_type = (Int16) -> Int16;

func called_func(function:test_func_type, int16_param: Int16): Int16 { return function(int16_param) };

func testFunc(param: Int16): Int16 { return param; }
func other_func(param: Int16): Int16 { return param + 1; }

main() {

//Test_case_1
    var func_result_01: Int16 = called_func(testFunc, 111);
    Assert.equals(111, func_result_01, 
        reason:"""
Test_case_1: Function, declared with parameter of type 'Function', 
returns unexpected result, when Function parameter is passed as name of function.
""");

//Test_case_2
    var source_func_var: test_func_type = testFunc;
    var func_result_02: Int16 = called_func(source_func_var, 222);
    Assert.equals(222, func_result_02, 
        reason:"""
Test_case_2: Function, declared with parameter of type 'Function', 
returns unexpected result, when Function parameter is passed as 
variable of type 'Function' .
""");

//Test_case_3
    var target_func_var = source_func_var;
    let isExpectedType: Bool = target_func_var is test_func_type;
    Assert.equals(true, isExpectedType, 
        reason:"""
Test_case_3: A variable, initialized with the value of another 
source variable of type 'Function', has unexpected type.
""");

//Test_case_4
    var func_result_03 = called_func(target_func_var, 333);
    Assert.equals(333, func_result_03, 
        reason:"""
Test_case_4: Function, declared with parameter of type 'Function', 
returns unexpected result, when Function parameter is passed as 
variable of type 'Function', initialized with the value of 
another source variable of type 'Function'.
""");

//Test_case_5
    source_func_var = other_func;
    var func_result_04 = called_func(source_func_var, 444);
    Assert.equals(445, func_result_04, 
        reason:"""
Test_case_5: Function, declared with parameter of type 'Function', 
returns unexpected result, when Function parameter is passed as 
source variable of type 'Function', reassigned by the name 
of another function of type 'Function'.
""");

//Test_case_6
    var func_result_05 = called_func(target_func_var, 555);
    Assert.equals(555, func_result_05, 
        reason:"""
Test_case_6: Function, declared with parameter of type 'Function', 
returns unexpected result, when Function parameter is passed as 
variable of type 'Function', initialized with the value of 
another source variable of type 'Function', when source variable
was reassigned.
It should not happen for 'value type' Function.
""");

    return 0;
}



