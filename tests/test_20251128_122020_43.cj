/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_a01_01

  @Level:         1

  @Assertion:       2.1.11(1) The enum type is immutable, and used to enumerate a set of related values 
  (called constructors). 
 
  @Description:     Checks that enum matching or unwrapping does not change 
  even if constructed from changing variables

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

enum E { |A(Int64) |B(String)}

main() {
    var a = 99
    var e = A(a)
    a = 45
    match (e) {
        case A(m) => Assert.equals(99, m)
        case _ => Assert.fail()
    }
    var s = "a=${a}"
    var e2 = B(s)
    s = "DFG"
    match (e2) {
      case B("DFG") => Assert.fail()
      case B("a=45") => ()
      case _ => Assert.fail()
    }

    var o = Some(a)
    a = 965
    Assert.equals(45, o ?? a)
}
