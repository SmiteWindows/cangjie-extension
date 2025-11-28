/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a08_011

  @Level:         1

  @Assertion:    2(8) Thus, when a variable is used in assignments and passed as a 
                 function parameter in a function call, its value is copied 
                 if it is of a value type and its reference is copied if it is of a reference type.

  @Description:  Checks that:
                 - variable of type 'Float16', used in assignment, 
                   is assigned to another variable by value,
                   what is correct for 'value type': Float16.
                 - variable of type 'Float16', used as function parameter, 
                   is passed to function by value, what is correct for 'value type': Float16.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

var func_param: Float16 = 0.0;
var func_param_copy: Float16 = 0.0;

func testFunc(param: Float16, to_do: Int8): Bool{
    if (to_do == 1){
        func_param_copy = param;
        return true;
    }

    if (to_do == 2){
        if (func_param_copy == param){
            return false;
        }
    }

    return true;
}

main() {
//Test_case_1
    var sourceVar: Float16 = 1.5;
    var targetVar: Float16 = sourceVar;
    sourceVar = 2.5;
    Assert.equals(1.5, targetVar, 
        reason:"""
Test_case_1: A variable of type 'Float16', used in assignment, 
is assigned to another variable not by value.
It is not correct for 'value type': Float16.
""");

//Test_case_2
    func_param = 3.5;
    testFunc(func_param, 1);
    func_param = 4.5;
    Assert.equals(true, testFunc(func_param, 2), 
        reason:"""
Test_case_2: A variable of type 'Float16', used as function parameter, 
is passed to function not by value.
It is not correct for 'value type': Float16.
""");

    return 0;
}


