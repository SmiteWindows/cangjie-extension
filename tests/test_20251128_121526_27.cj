/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a13_01

  @Level:         1

  @Assertion: 2.1.10.2(13)
              In addition, it is supported by using ! indicates whether the parameter is a named parameter.

  @Description: Check that member variable parameters can be named

  @Mode: run

  @Negative: no

  @Structure: single

  @Issue: 0006183

*/

import utils.assert.Assert

struct TestNoDefaults {
    TestNoDefaults(
        public let a!: Int64,
        public var b!: Float64,
        private let c!: (Int64, Int64),
        private var d!: () -> Int64,
        let e!: Array<Int64>,
        var f!: Bool
    ) {}

    func check() {
        Assert.equals(12, a)
        Assert.approxEquals(24.31, b)
        Assert.equals(-8, c[0])
        Assert.equals(31, c[1])
        Assert.equals(7, d())
        Assert.equals([1, 2], e)
        Assert.equals(true, f)
    }
}

struct TestDefaults {
    TestDefaults(
        public let a!: Int64 = 5,
        public var b!: Float64 = 0.18,
        private let c!: (Int64, Int64) = (10, 10),
        private var d!: (Int64) -> Int64 = {x: Int64 => x + 1},
        let e!: Array<Int64> = [],
        var f!: Bool = true
    ) {}

    func check() {
        Assert.equals(5, a)
        Assert.approxEquals(0.18, b)
        Assert.equals(10, c[0])
        Assert.equals(10, c[1])
        Assert.equals(6, d(5))
        Assert.equals([], e)
        Assert.equals(true, f)
    }
}

struct TestDefaultsOverwritten {
    TestDefaultsOverwritten(
        public let a!: Int64 = 5,
        public var b!: Float64 = 0.18,
        private let c!: (Int64, Int64) = (10, 10),
        private var d!: (Int64) -> Int64 = {x: Int64 => x + 1},
        let e!: Array<Int64> = [],
        var f!: Bool = true
    ) {}

    func check() {
        Assert.equals(0, a)
        Assert.approxEquals(4.9406564584124654E-324, b)
        Assert.equals(1, c[0])
        Assert.equals(1, c[1])
        Assert.equals(4, d(5))
        Assert.equals([0, 0, 0], e)
        Assert.equals(false, f)
    }
}

main() {
    let case1 = TestNoDefaults(a: 12, b: 24.31, c: (-8, 31), d: { => 7 }, e: [1, 2], f: true)
    case1.check()

    let case2 = TestDefaults()
    case2.check()

    let case3 = TestDefaultsOverwritten(a: 0, b: 4.9406564584124654E-324, c: (1, 1),
        d: {x: Int64 => x - 1}, e: [0, 0, 0], f: false)
    case3.check()
}