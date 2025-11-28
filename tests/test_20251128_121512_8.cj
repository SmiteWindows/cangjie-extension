/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a34_22

  @Level:         1

  @Assertion: 2.1.10.2(34)
              Before all of the instance member variables are initialized,
              the constructor cannot use functions or lambda that capture this,
              but can use this.variableName (the syntax sugar variableName) to access initialized member variables.

  @Description: Check that a private instance mutable property
                can not be used inside a constructor before initialization
                of all member variables

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006226, 0006194, 0006124, 0006495

*/

struct Test {
    init() {
        let x = this.p
        m = 1
    }

    private mut prop p: Int64 {
        get() {
            10
        }
        set(v) {}
    }

    public var m: Int64
}

main() {
}