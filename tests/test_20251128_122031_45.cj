/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a04_02

  @Level:         1

  @Assertion:    3.2.3.2(4) A variable must be defined and initialized before being used.

  @Description:  Checks that defined but not initialized variable causes compilation errors.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

class Point {
    var x: Int32
    var y: Int32
    init(xx: Int32, yy: Int32) {
        if (this.x == this.y) {
            this.x = xx
            this.y = yy
        }
    }
}

main() {
}

