/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_04_01_a14_02

  @Level:         1

  @Assertion:   2.4.1(14) In the following example, parameters with Int type and Int32 type of can directly be added,
                as Int is defined as the alias of Int32, but function overloading can not be achieved by using aliases
                for the definition of function overloading): 
                    type Int = Int32
                    let numOne: Int32 = 10
                    let numTwo: Int = 20
                    let numThree = numOne + numTwo
                    func add(left: Int, right: Int32): Int { left + right }
                    func add(left: Int32, right: Int32): Int32 { left + right }  // error: invalid redeclaration of 
                                                                                    'add : (Int32, Int32)->Int32'

  @Description: Check hegative example

  @Mode:        compileonly

  @Negative:    yes

*/

type Int = Int32
func add(left: Int, right: Int32): Int { left + right }
func add(left: Int32, right: Int32): Int32 { left + right }  // error: invalid redeclaration of 
                                                             //   'add : (Int32, Int32)->Int32'

main(): Unit {}
