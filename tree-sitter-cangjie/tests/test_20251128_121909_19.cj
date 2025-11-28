/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a05_018

  @Level:         1

  @Assertion:    2(5) The value types include numeric types (include integer types and 
                 floating-point types, see Numeric Types), Rune type, Bool type, 
                 Unit type, Nothing type, String type, Tuple type, Range type, 
                 Function type, struct type, enum type and VArray type. 

  @Description:  Checks that: 
                 - variable, initialized with the value of another source variable of type 'Tuple',
                   has the same type 'Tuple';
                 - variable, initialized with the value of another source variable of type 'Tuple',
                   has the same value as source variable;
                 - variable of type 'Tuple' after reassigning has new corrrect value;
                 - type 'Tuple' actualy is 'value type';

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

main() {
    var sourceVar:(Int32, Rune) = (1, r'1');
    var targetVar = sourceVar;

//Test_case_1
    let isExpectedType: Bool = targetVar is (Int32, Rune);
    Assert.equals(true, isExpectedType, 
        reason:"""
Test_case_1: A variable, initialized with the value of another source variable of type 'Tuple', 
has unexpected type.
""");

//Test_case_2
    let is_expected_value_2: Bool = sourceVar == targetVar;
    Assert.equals(true, is_expected_value_2, 
        reason:"""
Test_case_2: A variable, initialized with the value of another source variable of type 'Tuple', 
has unexpected value.
""");

//Test_case_3
    sourceVar = (2, r'1');
    let is_expected_value_3: Bool = (2, r'1') == sourceVar;
    Assert.equals(true, is_expected_value_3, 
        reason:"Test_case_3: A variable of type 'Tuple' has unexpected value after reassigning.");

//Test_case_4
    let is_expected_value_4: Bool = (1, r'1') == targetVar;
    Assert.equals(true, is_expected_value_4, 
        reason:"""
Test_case_4: A variable, initialized with the value 
of another source variable of type 'Tuple', 
has a value different from value of initializing 
after source variable has been reaasigned.
It should not happen for 'value type' Tuple.
""");

    return 0;
}

