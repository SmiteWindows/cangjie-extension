/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a09_02

  @Level:         1

  @Assertion: 2.1.10.2(9)
              The member variable parameter is introduced to reduce code redundancy.
              Defines a member variable parmeter, including the definitions of both a parameter
              and a member variable.

  @Description: Check that member variable parameters create an instance member of the struct

  @Mode: run

  @Negative: no

  @Structure: single

  @Issue: 0006183

*/

import utils.assert.Assert

struct S {
    var a = 15
    init(x: Int64) {
        a = x
    }
    init() {}
}

class A {
    var a = 15
    init(x: Int64) {
        a = x
    }
    init() {}
}

enum E {
    M(Int64) | D(Float64)
}

struct UnnamedParams {
    UnnamedParams(
                  public let p1: Int64,
                  public var p2: Int32,
                  public let p3: Int16,
                  private var p4: Int8,
                  private let p5: Float16,
                  private var p6: Float32,
                  let p7: Float64,
                  var p8: Unit,
                  public let p9: Rune,
                  public var p10: String,
                  public let p11: (Int64, Int64, Int64),
                  private var p12: Range<Int64>,
                  private let p13: (Int64, Int64) -> Int64,
                  private var p14: Array<Int64>,
                  let p15: S,
                  var p16: A,
                  let p17: E) {}

    // Check that variable created by unnamed parameters
    // can be accessed through a struct instance
    func check(test: UnnamedParams) {
        Assert.equals(10, test.p1)
        Assert.equals(11i32, test.p2)
        Assert.equals(12i16, test.p3)
        Assert.equals(13i8, test.p4)
        Assert.approxEquals(0.11f16, test.p5)
        Assert.approxEquals(0.11e-10f32, test.p6)
        Assert.approxEquals(0.11e-100, test.p7)
        Assert.isTrue(test.p8 is Unit)
        Assert.equals(r'a', test.p9)
        Assert.equals("A", test.p10)
        Assert.equals(1, test.p11[0])
        Assert.equals(2, test.p11[1])
        Assert.equals(3, test. p11[2])
        Assert.equals(-100..100:2, test.p12)
        Assert.equals(-1, test.p13(-100, 99))
        Assert.equals([1, 2, 3, 4, 5], test.p14)
        Assert.equals(-7, test.p15.a)
        Assert.equals(7, test.p16.a)

        let t = match(test.p17) {
            case D(a) => a
            case _ => 0.0
        }
        Assert.approxEquals(1.76, t)
    }
}

struct NamedParams {
    NamedParams(
                public let p1!: Int64,
                public var p2!: Int32,
                public let p3!: Int16,
                private var p4!: Int8,
                private let p5!: Float16,
                private var p6!: Float32,
                let p7!: Float64,
                var p8!: Unit,
                public let p9!: Rune,
                public var p10!: String,
                public let p11!: (Int64, Int64),
                private var p12!: Range<Int64>,
                private let p13!: (Int64, Int64) -> Int64,
                private var p14!: Array<Int64>,
                let p15!: S,
                var p16!: A,
                let p17!: E) {}

    // Check that variable created by named parameters
    // can be accessed through a struct instance
    func check(test: NamedParams) {
        Assert.equals(100, test.p1)
        Assert.equals(50i32, test.p2)
        Assert.equals(25i16, test.p3)
        Assert.equals(12i8, test.p4)
        Assert.approxEquals(-.416841f16, test.p5)
        Assert.approxEquals(-.04419f32, test.p6)
        Assert.approxEquals(-.419841, test.p7)
        Assert.isTrue(test.p8 is Unit)
        Assert.equals(r'b', test.p9)
        Assert.equals("B", test.p10)
        Assert.equals(10, test.p11[0])
        Assert.equals(20, test.p11[1])
        Assert.equals(1..4:1, test.p12)
        Assert.equals(1, test.p13(100, 99))
        Assert.equals([1, 2], test.p14)
        Assert.equals(10, test.p15.a)
        Assert.equals(9, test.p16.a)

        let t = match(test.p17) {
            case M(a) => a
            case _ => 0
        }
        Assert.equals(2, t)
    }
}

struct MixedParams {
    MixedParams(
                let a: Int64,
                var b: Float64,
                public let c!: Rune,
                private var d!: String,
                let e!: Bool) {}

    // Check that variable created by struct parameters
    // can be accessed through a struct instance
    func check(test: MixedParams) {
        Assert.equals(1, test.a)
        Assert.approxEquals(-7.7, test.b)
        Assert.equals(r'c', test.c)
        Assert.equals("x", test.d)
        Assert.equals(false, test.e)
    }
}

struct MixedParamsRegular {
    MixedParamsRegular(a: Int64, b: Float64, private let c: Rune, let d!: String, public let e!: Bool) {}

    // Check that variable created by struct parameters
    // can be accessed through a struct instance
    func check(test: MixedParamsRegular) {
        Assert.equals(r'c', test.c)
        Assert.equals("x", test.d)
        Assert.equals(false, test.e)
    }
}

struct Default {
    Default(
            public let p1!: Int64 = 0,
            public var p2!: Int32 = 1i32,
            public let p3!: Int16 = 2i16,
            private var p4!: Int8 = 3i8,
            private let p5!: Float16 = 0.1f16,
            private var p6!: Float32 = 0.01f32,
            let p7!: Float64 = 0.001,
            var p8!: Unit = (),
            public let p9!: Rune = r'o',
            public var p10!: String = "s",
            public let p11!: (Int64, Int64) = (-1, -1),
            private var p12!: Range<Int64> = 1..10:1,
            private let p13!: (Int64, Int64) -> Int64 = {x: Int64, y: Int64 => x * y},
            private var p14!: Array<Int64> = [1, 1, 1],
            let p15!: S = S(17),
            var p16!: A = A(99),
            let p17!: E = E.M(35)) {}

    // Check that variable created by named parameters with default values
    // can be accessed through a struct instance
    func check(test: Default) {
        Assert.equals(0, test.p1)
        Assert.equals(1i32, test.p2)
        Assert.equals(2i16, test.p3)
        Assert.equals(3i8, test.p4)
        Assert.approxEquals(0.1f16, test.p5)
        Assert.approxEquals(0.01f32, test.p6)
        Assert.approxEquals(0.001, test.p7)
        Assert.isTrue(test.p8 is Unit)
        Assert.equals(r'o', test.p9)
        Assert.equals("s", test.p10)
        Assert.equals(-1, test.p11[0])
        Assert.equals(-1, test.p11[1])
        Assert.equals(1..10:1, test.p12)
        Assert.equals(9900, test.p13(100, 99))
        Assert.equals([1, 1, 1], test.p14)
        Assert.equals(17, test.p15.a)
        Assert.equals(99, test.p16.a)

        let t = match(test.p17) {
            case M(a) => a
            case _ => 0
        }
        Assert.equals(35, t)
    }
}

struct DefaultOverwritten {
    DefaultOverwritten(
                       public let p1!: Int64 = 0,
                       public var p2!: Int32 = 1i32,
                       public let p3!: Int16 = 2i16,
                       private var p4!: Int8 = 3i8,
                       private let p5!: Float16 = 0.1f16,
                       private var p6!: Float32 = 0.01f32,
                       let p7!: Float64 = 0.001,
                       var p8!: Unit = (),
                       public let p9!: Rune = r'o',
                       public var p10!: String = "s",
                       public let p11!: (Int64, Int64) = (-1, -1),
                       private var p12!: Range<Int64> = 1..10:1,
                       private let p13!: (Int64, Int64) -> Int64 = {x: Int64, y: Int64 => x * y},
                       private var p14!: Array<Int64> = [1, 1, 1],
                       let p15!: S = S(17),
                       var p16!: A = A(99),
                       let p17!: E = E.M(35)) {}

    // Check that variable created by named parameters with default values
    // can be accessed through a struct instance
    func check(test: DefaultOverwritten) {
        Assert.equals(100, test.p1)
        Assert.equals(50i32, test.p2)
        Assert.equals(25i16, test.p3)
        Assert.equals(12i8, test.p4)
        Assert.approxEquals(-.416841f16, test.p5)
        Assert.approxEquals(-.04419f32, test.p6)
        Assert.approxEquals(-.419841, test.p7)
        Assert.isTrue(test.p8 is Unit)
        Assert.equals(r'b', test.p9)
        Assert.equals("B", test.p10)
        Assert.equals(10, test.p11[0])
        Assert.equals(20, test.p11[1])
        Assert.equals(1..4:1, test.p12)
        Assert.equals(1, test.p13(100, 99))
        Assert.equals([1, 2], test.p14)
        Assert.equals(-1, test.p15.a)
        Assert.equals(-2, test.p16.a)

        let t = match(test.p17) {
            case M(a) => a
            case _ => 0
        }
        Assert.equals(-3, t)
    }
}

main() {
    var a = A()
    a.a = 7
    var s = S()
    s.a = -7
    var e = E.D(1.76)
    // Check various types for unnamed parameters
    let case1 = UnnamedParams(10, 11i32, 12i16, 13i8, 0.11f16, 0.11e-10f32, 0.11e-100, (), r'a', "A", 
                              (1, 2, 3), -100..100:2, {x: Int64, y: Int64 => x + y}, [1, 2, 3, 4, 5],
                              s, a, e)
    case1.check(case1)

    a.a = 9
    s.a = 10
    e = E.M(2)
    // Check various types for named parameters
    let case2 = NamedParams(
        p1: 100,
        p2: 50i32,
        p3: 25i16,
        p4: 12i8,
        p5: -.416841f16,
        p6: -.04419f32,
        p7: -.419841,
        p8: (),
        p9: r'b',
        p10: "B",
        p11: (10, 20),
        p12: 1..4:1,
        p13: {x: Int64, y: Int64 => x - y },
        p14: [1, 2],
        p15: s,
        p16: a,
        p17: e
    )

    case2.check(case2)

    // Check the mix of parameters
    let case3 = MixedParams(1, -7.7, c: r'c', d: "x", e: false)
    case3.check(case3)

    // Check the mix of regular and struct members parameters
    let case4 = MixedParamsRegular(1, -7.7, r'c', d: "x", e: false)
    case4.check(case4)

    // Check the default values
    let case5 = Default()
    case5.check(case5)

    // Check the default values but overwritten
    let case6 = DefaultOverwritten(
        p1: 100,
        p2: 50i32,
        p3: 25i16,
        p4: 12i8,
        p5: -.416841f16,
        p6: -.04419f32,
        p7: -.419841,
        p8: (),
        p9: r'b',
        p10: "B",
        p11: (10, 20),
        p12: 1..4:1,
        p13: {x: Int64, y: Int64 => x - y },
        p14: [1, 2],
        p15: S(-1),
        p16: A(-2),
        p17: E.M(-3)
    )
    case6.check(case6)
}