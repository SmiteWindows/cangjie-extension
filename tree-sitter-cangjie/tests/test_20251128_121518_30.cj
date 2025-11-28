/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a04_19

  @Level:         1

  @Assertion:       2.1.10.4(4) Member variables defined within primary constructor can only be modified with
                    visibility modifiers (i.e. public or private, leaving it out is Default), not with the static
                    modifier.

  @Description:     Check that member variables of the primary constructor can be public and private inside one primary
                    constructor.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

import utils.assert.Assert

struct S1 {
    S1(private let a: Int64, public let b: Int64) {}
    func test() {
        Assert.equals(0, a)
        Assert.equals(2, b)
    }
}
struct S2 {
    S2(public let a: Int64, private var b: Int32) {}
    func test() {
        Assert.equals(0, a)
        Assert.equals(2, b)
    }
}

main() {
    Assert.equals(2, S1(0, 2).b)
    Assert.equals(0, S2(0, 2).a)
}
