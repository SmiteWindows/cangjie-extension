/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Description:  This file defines various top-level constants, variables, functions, classes and others.
  @Structure:    complex-aux
*/
package somepackage

// Constants & Variables
let str1 = "qwerty"
let ch1 = 'i'
var num1 = 630002
var bool1 = true
var tuple1 = ('c', 99)
let range1 = 0..11:3

// Function
func someFunc():String {
    return "bla-bla-result123!";
}

// Structure
struct Struct1 {
  let a = 1
  var b = 2
}

// Class
open class Class1 {
  let c = 6.7523468
  var d = [6,5,4,3]
}

// Interface
interface Inter1 {
    func getInt(): Int64
}

// Enum
enum AbcEnum { A ; | B ; | C }

