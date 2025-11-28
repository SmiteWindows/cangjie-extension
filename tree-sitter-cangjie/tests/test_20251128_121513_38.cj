/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a40_02

  @Level:         1

  @Assertion: 2.1.10.2(40)
              If a constructor does not explicitly call other constructors,
              ensure that all instance member variables declared in this struct
              have been initialized before returned from the constructor.
              Otherwise, an error will be reported during compilation.

  @Description: Check that an error is produced if a struct has a single constructor
                that does not initialize a public mutable instance variable

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init() {}

    public var x: Int64
}

main() {
}