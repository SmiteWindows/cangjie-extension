/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_02_01_a02_05

  @Level:         1
  @Assertion:    3.3.2.1(2) Note that each variable must be initialized before being used.
                 Otherwise, a compilation error is reported.

  @Description:  Checks that immutable function variable can't be used after conditional initialization

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    single

*/

func func1(trigger: Bool): Float32 {
    let a: Float32
    if (trigger) {
        a = .666
    }

    return a
}

main() {
    return 1;
}
