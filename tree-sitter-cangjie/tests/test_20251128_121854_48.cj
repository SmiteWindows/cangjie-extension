/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a06_01

  @Level:         1
  @Assertion:       3.2.2(6) 3. Names introduced inside a type or a block, whose defition is usually enclosed 
                    in a pair of curly braces {} (i.e., a block), have higher scope level than the names outside 
                    the curly braces.

  @Description:     Check that the following order of scopes applies to member functions (high to low): local scope,
                    class scope (member names, generic type name, and class name), top-level scope, imported package
                    scope;
                    to blocks: inside block scope, outside block scope (main in this test), top-level scope, imported
                    package scope.

  @Issue:           6525

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a06_01.cj
  @CompileWarning:  no

*/

import p

import utils.assert.Assert

/*Scope nesting:
default:
  utils.Assert
  p
  p.T
  p.T.a
  p.g
  GLOBAL_VAR
  f
  C:
    T
    f
    g
    test:
      T
      inner
      g
      GLOBAL_VAR
    a
  C.test
  I:
    T
    a
  I.a
  S:
    T
    test
  S.test
  main:
    g
    GLOBAL_VAR
*/

let GLOBAL_VAR = "val"

func f() { 0.431 }

class C<T> <: I<T> {
    func test<T>(val: T) {
        let inner: T = val
        Assert.isTrue(inner is UInt64) // Check that T from the function scope is UInt64
        Assert.isTrue(g is Int64) // Check that this.T is Int64
        Assert.equals(3, p.AuxTestA0601.a) // Check that it's possible to use T from a package
        Assert.equals(90, a()) // super.a()

        let g = 0.1
        Assert.approxEquals(0.1, g)
        Assert.isTrue(g is Float64)
        Assert.isTrue(this.g is Int64)
        Assert.equals(13, p.g())

        Assert.equals(1, f())

        Assert.equals("val", GLOBAL_VAR)
        let GLOBAL_VAR = "var"
        Assert.equals("var", GLOBAL_VAR)

        310u32
    }

    private func f() { 1i32 }
    private var g: T
    init(a:T) {
        g = a
    }
}

struct S<T> {
    var a: T
    init(a:T) {
        this.a = a
    }
    prop test: Int64 {
        get() {
            Assert.equals(3, p.AuxTestA0601.a)
            Assert.equals(13, p.g())
            Assert.approxEquals(0.431, f())

            Assert.equals(310, C<Int64>(10).test<UInt64>(0xfffffff))
            Assert.equals(90, C<Int64>(10).a())

            let C: T = a
            Assert.isTrue(C is Int32)

            313
        }
    }
}

interface I<T> {
    func a() {
        Assert.equals(3, p.AuxTestA0601.a)
        Assert.equals(13, p.g())
        Assert.approxEquals(0.431, f())

        90
    }
}

main() {
    Assert.equals(13, p.g())
    let g = 564

    if (p.g() == 13) { // Check the first block
        let g = 0.16f16
        Assert.approxEquals(0.16, g)
    }
    for (g in [6]) { // Check the second block
        Assert.equals(6, g)
    }
    { => // Check the third block
        let g = 1..2
        Assert.equals(1..2, g)
    }()

    // Check type scopes
    Assert.equals(313, S<Int32>(0xfffffff).test)
    Assert.equals(310, C<Int64>(10).test<UInt64>(10))

    Assert.equals(3, p.AuxTestA0601.a)
    Assert.equals(564, g)
    Assert.approxEquals(0.431, f())

    // Check top-level scope
    Assert.equals("val", GLOBAL_VAR)
    let GLOBAL_VAR = "varg"
    Assert.equals("varg", GLOBAL_VAR)

    // Check nested scopes
    unsafe { // 1
        let GLOBAL_VAR = "unsafe"
        let unsafeVar = 1

        func localFunc(GLOBAL_VAR: String) { // 2
            let funcVar = 2

            while (GLOBAL_VAR.size > 1) { // 3
                let whileVar = 3

                for (GLOBAL_VAR in [GLOBAL_VAR + "g"]) { // 4
                    let forVar = 4

                    if (GLOBAL_VAR.size == 2) { // 5
                        let ifVar = 5
                        let GLOBAL_VAR = "TRUE_GLOBAL_VAR"

                        Assert.equals("TRUE_GLOBAL_VAR", GLOBAL_VAR)
                        Assert.equals(1, unsafeVar)
                        Assert.equals(2, funcVar)
                        Assert.equals(3, whileVar)
                        Assert.equals(4, forVar)
                        Assert.equals(5, ifVar)
                    }

                    Assert.equals("funcg", GLOBAL_VAR)
                    Assert.equals(1, unsafeVar)
                    Assert.equals(2, funcVar)
                    Assert.equals(3, whileVar)
                    Assert.equals(4, forVar)
                }

                Assert.equals("func", GLOBAL_VAR)
                Assert.equals(1, unsafeVar)
                Assert.equals(2, funcVar)
                Assert.equals(3, whileVar)
                break
            }

            Assert.equals("func", GLOBAL_VAR)
            Assert.equals(1, unsafeVar)
            Assert.equals(2, funcVar)
        }
        localFunc("func")

        Assert.equals("unsafe", GLOBAL_VAR)
        Assert.equals(1, unsafeVar)
    }
    Assert.equals("varg", GLOBAL_VAR)
}
