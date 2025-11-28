/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a21_05

  @Level:         1

  @Comment:      It is a header of a list of assetions which include current assertion: 
                 In addition to the preceding syntax definitions, local variables may be introduced 
                 in the following scenarios:

  @Assertion:    3.3.1(21) Parameters in function and lambda definitions. For details, see Parameters.

  @Description:  Parameters in lambda definition - check that local variable used as parameter in lambda 
                 function is invisibile out of scope
                 Case: before lambda function

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    print("${myInputAge}")
    let myAge = {myInputAge: Int32 => "My age is ${myInputAge}"}(50)
    print("${myAge}")
}