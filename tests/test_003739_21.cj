/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a04_18

  @Level:         1
  @Assertion:       2.1.10.4(4) Member variables defined within primary constructor can only be modified with
                    visibility modifiers (i.e. public or private, leaving it out is Default), not with the static
                    modifier.

  @Description:     Check that a custom modifier can't be a modifier of a member variable defined within primary
                    constructor.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

struct S {
    S(default let v: Int64) {}
}

main() {}
