/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a11_03

  @Level:         1

  @Assertion:       2.1.11.2(11) When an enum constructor conflicts with other names (variable names, type names), 
  neither the enum constructor nor the conflicting name can be used directly; 
  it must be used in a prefix-qualified manner.

  @Description:     Checks that conflicting variables and enum constructors can not be used w/o prefix

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single

  @Comment:

*/

enum A {
    | B
    | C(Bool)
}

let B = 0
var C = A.B

main() {
    var x = (B is Int64)
    var y = (C is A)

    C = C(true)
    match (C) {
      case C(m) => (m == true)
      case _ => (false)
    }
    return 0
}
