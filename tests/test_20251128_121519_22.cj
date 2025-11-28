/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_02_a11_01

  @Level:         1

  @Assertion:       2.1.11.2(11) When an enum constructor conflicts with other names (variable names, type names), 
  neither the enum constructor nor the conflicting name can be used directly; 
  it must be used in a prefix-qualified manner.

  @Description:     Checks that conflicting variables and enum constructors can be used with prefix

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

enum A {
    | B
    | C(Bool)
}

let B = 0
var C = A.B

main() {
    Assert.isTrue(B is Int64)
    Assert.isTrue(C is A)

    C = A.C(true)
    match (C) {
      case C(m) => Assert.isTrue(m)
      case _ => Assert.fail()
    }
}
