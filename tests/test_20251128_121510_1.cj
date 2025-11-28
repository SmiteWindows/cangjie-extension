/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_01_a02_03

  @Level:         1
  @Assertion:    3.3.2.1(2) Note that each variable must be initialized before being used.
                 Otherwise, a compilation error is reported.

  @Description:  Checks that only initialized immutable and mutable variables can be used
                 (Duplication of test03_03_02_01_A01_01 and test03_03_02_01_A03_01)

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/

import utils.assert.Assert

let STR_CONST: String = "学习进行时";

main() {
    // useless test #1
    let a: Int32 = 2
    Assert.equals(2, a, reason: "Int value must match")

    // useless test #2
    var b: Bool = false
    Assert.isFalse(b, reason: "Bool value must match")

    // useless test #3
    var f: Float16 = 0.0
    Assert.equals(.0, f, reason: "Float16 value must match")

    // useless test #4
    var s: String = STR_CONST
    Assert.equals(STR_CONST, s, reason: "String value must match")

    // useless test #5
    var a1: Int16 = 16
    Assert.equals(16, a1, reason: "Int value must match")
}
