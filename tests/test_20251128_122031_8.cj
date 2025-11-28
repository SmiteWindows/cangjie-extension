/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a19_18

  @Level:         1

  @Assertion: 2.1.10.2(19)
              The initial value expression can refer to other parameters that have been defined before the parameter
              (excluding instance member variables defined outside the primary constructor),
              but the values of these referred parameters and member variables cannot be modified

  @Description: Check that the initial value of a private let member variable parameter
                can not refer to an instance member variable

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    public var y = 10
    A(
      private let x!: Int64 = y
    ) {}
}

main() {
}