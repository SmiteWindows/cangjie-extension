/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:      03_02_03_02_a28_03

  @Level:         1

  @Assertion: 3.2.3.2(28)
    // a:The scope of a local variable begins after the declaration 

    let x = 4 
    func f(): Unit { 
        print("${x}") // Print 4 
        let x = 99 
        print("${x}") // Print 99 
    } 

    let y = 5 
    func g(): Unit { 
        let y = y       // 'y' in the right of '=' is the global variable 'y' 
        print("${y}") // Print 5 
        let z = z       // Error: unresolved identifier 'z' (in the right of '=') 
    } 

    // b: The scope of a local function begins after definition 
    func test1(): Unit { 
        func test2(): Unit { 
             print("test2") 
             test3()  // Error test3's scope is begin after definition 
        } 
        func test3(): Unit { 
             test2() 
        } 
        test2() 
    } 

    let score: Int64 = 90 
    let good = 70 

    var scoreResult: String = match (score) { // binding pattern 
        case 60 => "pass" // constant pattern. 
        case 100 => "Full" // constant pattern. 
        case good => "good" // This good has higher scope level than the good at line 2 
    } 

  @Description:  Check example from the Spec: negative case 2.
  @Mode:         compileonly
  @Negative:     yes
  @Structure:    single

*/

// b: The scope of a local function begins after definition 
func test1(): Unit { 
    func test2(): Unit { 
        print("test2") 
        test3()  // Error test3's scope is begin after definition 
    } 

    func test3(): Unit { 
        test2() 
    } 

    test2() 
}

main() {
}
