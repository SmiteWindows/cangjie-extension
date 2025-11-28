/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a05_18

  @Level:         1
  @Assertion:       2.1.10.4(5) The struct constructor can only be modified with visibility modifiers (i.e. public or
                    private, leaving it out is Default), not with static.

  @Description:     Check that "unsafe" can't be an init constructor modifier.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Issue:           0006435

*/

struct S {
    unsafe init() {}
}

main() {}
