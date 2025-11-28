/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a04_24

  @Level:         1

  @Assertion:    3.2.3.2(4) A variable must be defined and initialized before being used.

  @Description:  Checks that variable, defined and initialized after being used in class constructor,
                 causes compilation error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class A {
    init() {
        if (this.x == 0) {
            this.x = xx
            let xx: Int32 = 0
        }
    }

    var x: Int32 = 0
    var y: Int32 = 0
}

main() {
}

