/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a08_016

  @Level:         1

  @Assertion:    2(8) Thus, when a variable is used in assignments and passed as a 
                 function parameter in a function call, its value is copied 
                 if it is of a value type and its reference is copied if it is of a reference type.

  @Description:  Checks that:
                 - variable of type 'String', used in assignment, 
                   is assigned to another variable by value,
                   what is correct for 'value type': String.
                 - variable of type 'String', used as function parameter, 
                   is passed to function by value, what is correct for 'value type': String.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

var func_param: String = "";
var func_param_copy: String = "";

func testFunc(param: String, to_do: Int8): Bool{
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
    var sourceVar: String = "Str_1";
    var targetVar: String = sourceVar;
    sourceVar = "Str_2"
    Assert.equals("Str_1", targetVar, 
        reason:"""
Test_case_1: A variable of type 'String', used in assignment, 
is assigned to another variable not by value.
It is not correct for 'value type': String.
""");

//Test_case_2
    func_param = "AAAA";
    testFunc(func_param, 1);
    func_param = "BBBB";
    Assert.equals(true, testFunc(func_param, 2), 
        reason:"""
Test_case_2: A variable of type 'String', used as function parameter, 
is passed to function not by value.
It is not correct for 'value type': String.
""");

    return 0;
}


