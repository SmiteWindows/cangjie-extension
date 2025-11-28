/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a42_23

  @Level:         1

  @Assertion: 2.1.10.2(42)
              The return type of the constructor is Unit type.

  @Description: Check that constructors can not have a return statement
                of a class type

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

class A {}

struct Test {
    init() {
        return A()
    }
}

main() {
}