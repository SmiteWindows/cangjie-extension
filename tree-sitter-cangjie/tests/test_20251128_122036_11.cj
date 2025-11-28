/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a08_01

  @Level:         1

  @Assertion: 2.1.10.2(8)
              The syntax and semantics of regular parameters are consistent 
              with those in the function definition.

  @Description: Check that regular parameters behave like ordinary function parameters, namely:
                1. parameters are initialized with arguments of corresponding types
                   during the primary constructor invocation
                2. parameters are visible inside the primary constructor and contain values
                   that were passed through arguments during the constructor invocation
                3. parameters could be unnamed or named
                4. arguments for unnamed parameters are passed as values
                5. arguments for named parameters are passed as names plus values
                6. the ordering of arguments for named parameters is not fixed
                7. named parameters can have default values

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

var constructor_counter = 0

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
    UnnamedParams(p1: Int64, p2: Int32, p3: Int16, p4: Int8, p5: Float16, p6: Float32, p7: Float64,
                  p8: Unit, p9: Rune, p10: String, p11: (Int64, Int64, Int64), p12: Range<Int64>,
                  p13: (Int64, Int64) -> Int64, p14: Array<Int64>, p15: S, p16: A, p17: E) {
        Assert.equals(10, p1)
        Assert.equals(11i32, p2)
        Assert.equals(12i16, p3)
        Assert.equals(13i8, p4)
        Assert.approxEquals(0.11f16, p5)
        Assert.approxEquals(0.11e-10f32, p6)
        Assert.approxEquals(0.11e-100, p7)
        Assert.isTrue(p8 is Unit)
        Assert.equals(r'a', p9)
        Assert.equals("A", p10)
        Assert.equals(1, p11[0])
        Assert.equals(2, p11[1])
        Assert.equals(3, p11[2])
        Assert.equals(-100..100:2, p12)
        Assert.equals(-1, p13(-100, 99))
        Assert.equals([1, 2, 3, 4, 5], p14)
        Assert.equals(-7, p15.a)
        Assert.equals(7, p16.a)
        let t = match(p17) {
            case D(a) => a
            case _ => 0.0
        }
        Assert.approxEquals(1.76, t)
    }
}

struct NamedParams {
    NamedParams(p1!: Int64, p2!: Int32, p3!: Int16, p4!: Int8, p5!: Float16, p6!: Float32, p7!: Float64,
                p8!: Unit, p9!: Rune, p10!: String, p11!: (Int64, Int64), p12!: Range<Int64>,
                p13!: (Int64, Int64) -> Int64, p14!: Array<Int64>, p15!: S, p16!: A, p17!: E) {
        Assert.equals(100, p1)
        Assert.equals(50i32, p2)
        Assert.equals(25i16, p3)
        Assert.equals(12i8, p4)
        Assert.approxEquals(-.416841f16, p5)
        Assert.approxEquals(-.04419f32, p6)
        Assert.approxEquals(-.419841, p7)
        Assert.isTrue(p8 is Unit)
        Assert.equals(r'b', p9)
        Assert.equals("B", p10)
        Assert.equals(10, p11[0])
        Assert.equals(20, p11[1])
        Assert.equals(1..4:1, p12)
        Assert.equals(1, p13(100, 99))
        Assert.equals([1, 2], p14)
        Assert.equals(10, p15.a)
        Assert.equals(9, p16.a)
        let t = match(p17) {
            case M(a) => a
            case _ => 0
        }
        Assert.equals(2, t)
    }
}

struct MixedParams {
    MixedParams(a: Int64, b: Float64, c!: Rune, d!: String, e!: Bool) {
        Assert.equals(1, a)
        Assert.approxEquals(-7.7, b)
        Assert.equals(r'c', c)
        Assert.equals("x", d)
        Assert.equals(false, e)
    }
}

struct Ordering {
    Ordering(a!: Int64, b!: Int64, c!: Int64) {
        Assert.equals(1, a)
        Assert.equals(2, b)
        Assert.equals(3, c)
    }
}

struct Default {
    Default(p1!: Int64 = 0,
            p2!: Int32 = 1i32,
            p3!: Int16 = 2i16,
            p4!: Int8 = 3i8,
            p5!: Float16 = 0.1f16,
            p6!: Float32 = 0.01f32,
            p7!: Float64 = 0.001,
            p8!: Unit = (),
            p9!: Rune = r'o',
            p10!: String = "s",
            p11!: (Int64, Int64) = (-1, -1),
            p12!: Range<Int64> = 1..10:1,
            p13!: (Int64, Int64) -> Int64 = {x: Int64, y: Int64 => x * y},
            p14!: Array<Int64> = [1, 1, 1],
            p15!: S = S(17),
            p16!: A = A(99),
            p17!: E = E.M(35)) {
        Assert.equals(0, p1)
        Assert.equals(1i32, p2)
        Assert.equals(2i16, p3)
        Assert.equals(3i8, p4)
        Assert.approxEquals(0.1f16, p5)
        Assert.approxEquals(0.01f32, p6)
        Assert.approxEquals(0.001, p7)
        Assert.isTrue(p8 is Unit)
        Assert.equals(r'o', p9)
        Assert.equals("s", p10)
        Assert.equals(-1, p11[0])
        Assert.equals(-1, p11[1])
        Assert.equals(1..10:1, p12)
        Assert.equals(9900, p13(100, 99))
        Assert.equals([1, 1, 1], p14)
        Assert.equals(17, p15.a)
        Assert.equals(99, p16.a)
        let t = match(p17) {
            case M(a) => a
            case _ => 0
        }
        Assert.equals(35, t)
    }
}

struct DefaultOverwritten {
    DefaultOverwritten(p1!: Int64 = 0,
                       p2!: Int32 = 1i32,
                       p3!: Int16 = 2i16,
                       p4!: Int8 = 3i8,
                       p5!: Float16 = 0.1f16,
                       p6!: Float32 = 0.01f32,
                       p7!: Float64 = 0.001,
                       p8!: Unit = (),
                       p9!: Rune = r'o',
                       p10!: String = "s",
                       p11!: (Int64, Int64) = (-1, -1),
                       p12!: Range<Int64> = 1..10:1,
                       p13!: (Int64, Int64) -> Int64 = {x: Int64, y: Int64 => x * y},
                       p14!: Array<Int64> = [1, 1, 1],
                       p15!: S = S(17),
                       p16!: A = A(99),
                       p17!: E = E.M(35)) {
        Assert.equals(100, p1)
        Assert.equals(50i32, p2)
        Assert.equals(25i16, p3)
        Assert.equals(12i8, p4)
        Assert.approxEquals(-.416841f16, p5)
        Assert.approxEquals(-.04419f32, p6)
        Assert.approxEquals(-.419841, p7)
        Assert.isTrue(p8 is Unit)
        Assert.equals(r'b', p9)
        Assert.equals("B", p10)
        Assert.equals(10, p11[0])
        Assert.equals(20, p11[1])
        Assert.equals(1..4:1, p12)
        Assert.equals(1, p13(100, 99))
        Assert.equals([1, 2], p14)
        Assert.equals(-1, p15.a)
        Assert.equals(-2, p16.a)
        let t = match(p17) {
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

    // Check the mix of parameters
    let case3 = MixedParams(1, -7.7, c: r'c', d: "x", e: false)

    // Check the ordering of arguments for unnamed parameters
    let case4 = Ordering(c: 3, b: 2, a: 1)

    // Check the default values
    let case5 = Default()

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
}
