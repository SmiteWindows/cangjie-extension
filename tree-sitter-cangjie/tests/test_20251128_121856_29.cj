/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:           02_01_11_04_a03_10

  @Level:         1

  @Assertion:      2.1.11.4(3) The constructors, static member functions, and instance member functions 
  of an enum type cannot be overloaded. Therefore, the constructors, static member functions, 
  instance member functions, and member properties of the enum cannot have the same name. 

  @Description:     Checks that static member properties cannot overload instance member functions

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Issue: 0006124

*/

enum E {
    F | F1(Bool)
    static prop F2: Int64 {
        get() { 42 }
    }
    func F2(): Int32 { 42i32 } 
}

main() {}
