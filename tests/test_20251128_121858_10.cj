/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_05_a01_01

  @Level:         1

  @Assertion:    2.5(1) There are two kinds of relations between types: equivalence and subtyping.

  @Description:  Check that types can be equivalent and can be subtypes of each other

  @Mode:         run

  @Negative:     no

*/

import utils.assert.*

interface I {}

open class Base <: I {}
class Impl <: Base {}

type T = Int64

main() {
    // subtypes
    let base = Base()
    var impl = Impl()

    Assert.isTrue(base is I)
    Assert.isTrue(impl is I)
    Assert.isTrue(impl is Base)

    // equivalent
    let t: T = 96
    Assert.isTrue(t is Int64)
}


