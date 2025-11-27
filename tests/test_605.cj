/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a04_03

  @Level:         1
  @Assertion:       2.1.10.4(4) Member variables defined within primary constructor can only be modified with
                    visibility modifiers (i.e. public or private, leaving it out is Default), not with the static
                    modifier.

  @Description:     Check that "public" can be a modifier of a member variable of the primary constructor. Check the
                    behavior matches the public visibility.

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a04_03.cj
  @CompileWarning:  no

*/

import p3.*

import utils.assert.Assert

main() {
    // A public member variable of the primary constructor is visible outside its package.
    let s1 = getS1()
    Assert.equals(0, s1.a)
    Assert.equals(2, s1.b)

    let s2 = getS2()
    Assert.equals(0, s2.a)
    Assert.equals(2, s2.b)

    let s3 = getS3()
    Assert.equals(0, s3.a)
    Assert.equals(2, s3.b)

    let s4 = getS4()
    Assert.equals(0, s4.a)
    Assert.equals(2, s4.b)

    let s5v1 = getS5v1()
    Assert.equals(0, s5v1.a)
    Assert.equals(2, s5v1.b)

    let s5v2 = getS5v2()
    Assert.equals(0, s5v2.a)
    Assert.equals(2, s5v2.b)

    let s6v1 = getS6v1()
    Assert.equals(0, s6v1.a)
    Assert.equals(2, s6v1.b)

    let s6v2 = getS6v2()
    Assert.equals(0, s6v2.a)
    Assert.equals(2, s6v2.b)

    let s7 = getS7()
    Assert.equals(0, s7.a)
    Assert.equals(2, s7.b)

    let s8v1 = getS8v1()
    Assert.equals(0, s8v1.a)
    Assert.equals(2, s8v1.b)

    let s8v2 = getS8v2()
    Assert.equals(0, s8v2.a)
    Assert.equals(2, s8v2.b)

    test()
}
