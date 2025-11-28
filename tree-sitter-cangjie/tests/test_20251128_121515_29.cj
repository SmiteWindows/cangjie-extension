/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a05_05

  @Level:         1

  @Assertion:    3.3.1(5) The modifiers of member variables of the class type are as follows: 
                 public, protected, private, static.

  @Description:  Check that top-level immutable member of the class variable declaration can't 
                 include modifiers except of: public, protected, private, static.
                 Typo in 'public'

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class MyClass {
    publik let classLetPublic: Int32 = 0
}

main() {
}