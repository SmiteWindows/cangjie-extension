/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a26_08

  @Level:         1

  @Assertion: 2.1.10.2(26)
              A primary constructor is a syntax sugar of regular constructor.
              The compiler automatically generates a definition of the constructor
              and member variables corresponding to the main constructor,
              the form of the automatically generated constructor is as follows:
              • The modifier is the same as that of the primary constructor.
              • The sequence of parameters from left to right is the same as that of parameters
                declared in the primary constructor parameter list.
              • The constructor body is in the following format:
                – Assign values to member variables in sequence.
                  The syntax format is this.x = x, where x indicates the member variable name.
                – Then other code inside the primary constructor body.

  @Description: Check that a constructor generated from a default primary constructor
                is invisible outside the package

  @Mode: compileonly

  @Negative: yes

  @Structure: complex-main

  @Dependencies: a26_neg.cj

*/

import a26_neg.*

main() {
    let tst = Default()
}