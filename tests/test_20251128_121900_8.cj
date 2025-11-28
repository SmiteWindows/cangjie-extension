/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a02_01

  @Level:         1

  @Assertion:       2.1.10.5(2) The definition for an instance of a struct can be divided into two kinds, according to
                    whether the struct is generic:

  @Description:     Check that it's possible to create instances of 2 kinds of structs.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

*/

struct S {
    let v = 0
}

struct S1<T> {
    let v: T
    init(v: T) { this.v = v }
}

main() {
    S()
    S1<Int64>(0)
    0
}
