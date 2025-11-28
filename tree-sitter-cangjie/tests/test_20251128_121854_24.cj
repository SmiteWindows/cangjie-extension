/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a05_01

  @Level:         1
  @Assertion:       2.1.10.4(5) The struct constructor can only be modified with visibility modifiers (i.e. public or
                    private, leaving it out is Default), not with static.

  @Description:     Check that both type of struct constructors can have public, default or private visibility.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

struct S {
    public init() {}
}
struct S1 {
    init() {}
}
struct S2 {
    private init() {}
}
struct S3 {
    public S3() {}
}
struct S4 {
    S4() {}
}
struct S5 {
    private S5() {}
}

main() {}
