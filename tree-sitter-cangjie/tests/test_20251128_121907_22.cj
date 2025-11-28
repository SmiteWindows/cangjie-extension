/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        03_02_03_01_a05_01

  @Level:         1
  @Assertion:   3.2.3.1(5)
    /* Global variables can be accessed only after defined. */ 
    let x = y           //Error: y is used before being defined 
    let y = 4 
    let a = b           //Error: b is used before being defined 
    let b = a 
    let c = c           //Error: unresolved identifier 'c' (in the right of '=') 

    //Function names are visible in the entire package 
    func test() { test2() }       // OK 
    func f() { test() } // OK 
    func test2(): Int64 { 
        var x = 99 
        return x 
    }
    let x = y           //Error: y is used before being defined 
    let y = 4 

  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single
*/

let x = y  //Error: y is used before being defined 
let y = 4 

main() {
  return 0
}
