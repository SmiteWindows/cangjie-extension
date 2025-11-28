/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_01_10_a05_02

  @Level:         1

  @Assertion:   2.1.10(5) As custom types, struct types do not support == (and ! =) by default.

  @Description: Checks that the try to compare with '!=' operator two variables of 
                type 'struct' causes compilation error.

  @Mode:        compileOnly
  @Negative:    yes
  @Structure:   single

*/

struct Struct1 {
}

struct Struct2 {
}

main() {
    var struct1: Struct1 = Struct1();
    var struct2: Struct2 = Struct2();
    var isNotEquals = (struct1 != struct2);
}


