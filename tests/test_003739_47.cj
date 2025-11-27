/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a41_05

  @Level:         1

  @Assertion: 2.1.10.2(41)
              The compiler analyzes the dependency between all constructors.
              If a cyclic invoking is performed, an error is reported.

  @Description: Check that a cyclic chain of multiple constructor calls through 'this'
                causes an error

  @Mode: compileonly

  @Negative: yes

  @Structure: single

*/

struct A {
    init() {
        this(1)
    }

    init(x: Int64) {
        this(false)
    }

    init(x: Bool) {
        this((1, 1))
    }

    init(x: (Int64, Int64)) {
        this('a')
    }

    init(x: Rune) {
        this(0.1)
    }

    init(x: Float64) {
        this(true, true)
    }

    init(x: Bool, y: Bool) {
        this(1, 2)
    }

    init(x: Int64, y: Int64) {
        this([x, y])
    }

    init(x: Array<Int64>) {
        this("${x}")
    }

    init(x: String) {
        this()
    }
}

main() {
}