/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a04_02

  @Level:         1
  @Assertion:       2.1.10.4(4) Member variables defined within primary constructor can only be modified with
                    visibility modifiers (i.e. public or private, leaving it out is Default), not with the static
                    modifier.

  @Description:     Check that the modifier for a primary constructor member variable is optional. Check the behavior
                    matches the default visibility, i.e. a primary constructor member variable is invisible outside its
                    package.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       complex-main
  @Dependencies:    aux_test_a04_02.cj
  @CompileWarning:  no

*/

import p2.*

main() {
    AuxTestA0402(1).v
    0
}
