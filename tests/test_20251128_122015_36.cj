/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a34_27

  @Level:         1

  @Assertion: 2.1.10.2(34)
              Before all of the instance member variables are initialized,
              the constructor cannot use functions or lambda that capture this,
              but can use this.variableName (the syntax sugar variableName) to access initialized member variables.

  @Description: Check that 'this' can not be captured by a local function inside a constructor
                before all member variables are initialized

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006226, 0006194, 0006495

*/

struct Test {
    init() {
        func f() {
            return this
        }
        m = 1
    }

    public var m: Int64
}

main() {
}