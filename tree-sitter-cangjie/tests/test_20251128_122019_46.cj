/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_01_a03_02

  @Level:         1

  @Assertion:   2.1.10.1(3) For any member variable, only initialized member variables defined 
                            before it and static member functions can be referenced in its default value expression.

  @Description: Checks that the case, when member variable is being initialized using 
                uninitialized member variable defined before it, 
                causes compilatopn error.

  @Mode:        compileonly
  @Negative:    yes
  @Structure:   single

*/

struct MyStruct {
    var var1: String;
    var var2: String = var1 + "_s2";
    MyStruct() {
        this.var1 = "s1";
    }
}

main() {
}


