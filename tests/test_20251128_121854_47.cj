/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_a06_001

  @Level:         1

  @Assertion:    2(6) The reference types include class type and interface type.

  @Description:  Checks that: 
                 - source variable, initialized with the value of type 'Array', has the expected value;
                 - variable, initialized with the value of another source variable of type 'Array',
                   has the same type 'Array';
                 - variable, initialized with the value of another source variable of type 'Array',
                   has expected value, the same as source variable;
                 - source variable of type 'Array' after reassigning has new corrrect value;
                 - type 'Array' actualy is 'reference type';

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:  

*/

import utils.assert.*

main() {
//Test_case_1
    var sourceArray: Array<Int32> = [0, 1, 2, 3, 4, 5];
    Assert.equals(3, sourceArray[3], 
        reason:"""
Test_case_1: Source variable, initialized with the value of type 'Array<Int32>', 
has the unexpected value for index = 3.
""");

//Test_case_2
    var targetArray = sourceArray;
    let isExpectedType: Bool = targetArray is Array<Int32>;
    Assert.equals(true, isExpectedType, 
        reason:"""
Test_case_2: A variable, initialized with the value of 
another source variable of type 'Array<Int32>', 
has unexpected type.
""");

//Test_case_3
    Assert.equals(0, targetArray[0], 
        reason:"""
Test_case_3: A variable, initialized by the value of 
another source variable of type 'Array<Int32>', 
has the unexpected value for index = 0.
""");

//Test_case_4
    sourceArray[2] = 99;
    Assert.equals(99, sourceArray[2], 
        reason:"""
Test_case_4: Source variable of type 'Array<Int32>' 
has unexpected value for index=2 after that array item was reassigned.
""");

/*
//Test_case_5
    Assert.equals(99, targetArray[2], 
        reason:"""
Test_case_5: A variable, initialized by the value 
of another source variable of type 'Array<Int32>', 
has value for index=2 different from the same value of the source variable
when the same item of source variable has been reaasigned.
It should not happen for 'reference type': Array.
""");
*/
    return 0;
}

