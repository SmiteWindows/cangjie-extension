/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a11_01

  @Level:         1
  @Assertion:    3.2.4(11) The following examples illustrate shadowing across different packages.


  @Mode:         run
  @Negative:     no
  @CompileWarning: yes
  @Structure:    complex-main
  @Dependencies: a.cj

*/

package p2

import utils.assert.Assert

import p1.A            // A belongs to the package p1
import p1.v            // v belongs to the package p1

// p2 has defined its own v, whose scope level is higher than the v from package p1
var v: Int32 = 20

func displayV1(): Unit {
     // According to the scope level, p2.v shadows p1.v, therefore access p2.v here
     print("${v}")              // output: 20
     Assert.equals(20, v)       // added to orig code
}

main() {
    var a = A()             // Invoke A in p1
    displayV1()             // added to orig code
}

