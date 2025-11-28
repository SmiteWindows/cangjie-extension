/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a07_54

  @Level:         1

  @Assertion:    3.3.1(7)  let is used to define immutable variables.  Once initialized, a let variable 
                 cannot be changed.

  @Description:  Check that initialized in constuctor struct member variable declared with 'let' 
                 and with specified type can't be changed in func

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

struct MyStruct { 
    let myLet: Int32
    MyStruct() {
        myLet = 8
    }

    func changeVal() {
        myLet = 9
    }
} 

main() {
} 

