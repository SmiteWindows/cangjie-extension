/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a10_03

  @Level:         1
  @Assertion:    3.2.4(10) The following example illustrate shadowing on variables in different scenarios.

  @Mode:         compileonly
  @Negative:     yes

*/

func f(x: Int32, y: Int32): Unit {
    var i = 1         // OK
    for (i in 1..3) { // OK, a new i in the block
        let v = 1
    }                 // i and v disappear

    print("${i}")     // OK. i is defined at line 9

    print("${v}")  // Error v disappeared and cannot be found
}

main() {
}
