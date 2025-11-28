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

// Constants
let str1 = "abcdf"
let ch1 = 'p'
let num1 = 3.14
let bool1 = true
let tuple1 = ('a', 97)
let range1 = 0..11:1
let struct1 = Struct1()
let arr1 = [1, 2, 3, 4, 5]

// Variables
var str2 = "fdcba"
var ch2 = 'o'
var num2 = 14.3
var bool2 = false
var tuple2 = ('b', 98)
var range2 = 0..11:2

var struct2 = Struct1()
var arr2 = [6, 7, 8, 9, 0]

// Function
func someFunc(): String {
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

