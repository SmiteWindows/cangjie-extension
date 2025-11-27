/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a24_01

  @Level:         1

  @Assertion: 2.1.10.2(24)
              Declarations and expressions are allowed in the primary constructor body
              but must meet the requirements of init constructors.

  @Description: Check that the listed elements are allowed in the primary constructor body

  @Mode: run

  @Negative: no

  @Structure: single

*/

import utils.assert.Assert

// Functions
struct A {
    A(x: Int64, y: Bool) {
        func f() {
            return x + 1
        }

        func g(a: Float64,b: Float64) {
            return a / b
        }

        func foo() {
            if (y) {
                return 5
            } else {
                return 6
            }
        }

        func bar() {
            return ""
        }

        func foobar() {}

        Assert.equals(2, f())
        Assert.approxEquals(0.5, g(1.0, 2.0))
        Assert.equals(5, foo())
        Assert.equals("", bar())
        Assert.isTrue(foobar() is Unit)
    }
}

// Variable declarations
struct B {
    B() {
        var _int8 = 1i8
        let _int16 = 2i16
        var _int32 = 3i32
        let _int64 = 4
        var _uint8 = 5u8
        let _uint16 = 6u16
        var _uint32 = 7u32
        let _uint64 = 8u64
        var _float16 = 0.5f16
        let _float32 = 0.01f32
        let _float64 = 100.1e100

        Assert.equals(1i8, _int8)
        Assert.equals(2i16, _int16)
        Assert.equals(3i32, _int32)
        Assert.equals(4, _int64)
        Assert.equals(5u8, _uint8)
        Assert.equals(6u16, _uint16)
        Assert.equals(7u32, _uint32)
        Assert.equals(8u64, _uint64)
        Assert.approxEquals(0.5f16, _float16)
        Assert.approxEquals(0.01f32, _float32)
        Assert.approxEquals(100.1e100, _float64)
    }
}

// Expressions
struct C {
    var a = 1
    var b = 2
    var c = 3
    var d = {x: Int64 => x * 2 }
    var e = {x: Int64 => x + 1}
    var f: (Int64) -> Int64
    
    C() {
        a = b + c
        Assert.equals(5, a)

        f = d ~> e
        Assert.equals(3, f(1))

        a = match(c) {
            case 1 => 1
            case _ => 100
        }

        Assert.equals(100, a)
    }
}

// Everything
struct D {
    D(x: Int64) {
        func f() {
            return x + 5
        }

        var z = x + 1
        var y = x

        let r = y * z / f()
        Assert.equals(7, r)
    }
}


main() {
    let case1 = A(1, true)

    let case2 = B()

    let case3 = C()

    let case4 = D(10)
}