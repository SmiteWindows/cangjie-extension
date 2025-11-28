/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a06_01

  @Level:         1
  @Assertion:       2.1.10.4(6) The members modified with private within struct are visible only within the definition
                    of struct.

  @Description:     Check that private struct members are only visible inside the struct. Check visibility inside the
                    struct.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue: 0006124

*/

import utils.assert.Assert

struct S {
    private static let statV: Int64 = 6
    private let v: Int64
    private static prop statP: Int64 {
        get() { 7 }
    }
    private static func statF() { 8 }
    private static func statT<T>() { 0 }

    init() { this(1) }
    private init(a: Int64) { this.v = a }

    private prop p: Int64 {
        get() { 2 }
    }

    private func f() { 3 }
    private func t<T>() { 4 }
    private operator func -(right: Int64) { right }

    func test() {
        Assert.equals(6, S.statV)
        Assert.equals(1, v)
        Assert.equals(7, S.statP)
        Assert.equals(8, S.statF())
        Assert.equals(0, S.statT<Nothing>())
        Assert.equals(2, p)
        Assert.equals(3, f())
        Assert.equals(4, t<Nothing>())
        Assert.equals(5, this - 5)
    }
}

main() {
    S().test()
}
