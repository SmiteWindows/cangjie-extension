/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_01_a06_05

  @Level:         1

  @Assertion:    3.1(6) 
    let f2 = 77 
    func f2() { // Error  function name is the same as the variable f2
        print("${f2}") 
    } 
    // Variable, function, type names cannot be the same as keywords
    let Int64 = 77     // Error: 'Int64' is a keyword 
    func class() {    // Error: class is a keyword 
        print("${f2}") 
    } 
    main(): Int64 { 
        print("${f2}")     // Print 77 
        let f2 = { => // Shadowed the global variable f2 
            print("10") 
        } 
        f2() 
        return 1 
    } 

  @Description:  Check the all cases from the example

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

let f2 = 77 
func f2() { // Error  function name is the same as the variable f2
    print("${f2}") 
} 
// Variable, function, type names cannot be the same as keywords
let Int64 = 77     // Error: 'Int64' is a keyword 
func class() {    // Error: class is a keyword 
    print("${f2}") 
} 
main(): Int64 { 
    print("${f2}")     // Print 77 
    let f2 = { => // Shadowed the global variable f2 
        print("10") 
    } 
    f2() 
    return 1 
}
