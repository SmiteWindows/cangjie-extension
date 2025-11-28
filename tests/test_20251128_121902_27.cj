/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            03_02_02_a09_01

  @Level:         1

  @Assertion:       3.2.2(9)
                        import p1.a     // a has the lowest scope level
                        var x = 1     // x r's scope level is higher than p1.a
                        open class A {      // A's scope level the same as x at line 3
                            var x = 3       // This x has higher scope level than the x at line 3
                            var y = r'a'
                            func f(a: Int32, b: Float64): Unit {
                            }
                        }
                        class B <: A {
                            // var x = 5     // A member of a subtype must not shadow a member of the supertype.
                            func f(x!: Int32 = 7) { // This x's scope level is higher than the x at line 14
                            }
                        }

  @Description:     Check that the Spec example works.

  @Mode:            run
  @Negative:        no
  @Structure:       complex-main
  @Dependencies:    aux_test_a09_01.cj
  @CompileWarning:  no

  @Issue:           0006086

*/

import utils.assert.Assert

import p1.a     // a has the lowest scope level
var x = 1     // x r's scope level is higher than p1.a
open class A {      // A's scope level the same as x at line 3
    var x = 3       // This x has higher scope level than the x at line 3
    var y = r'a'
    func f(a: Int32, b: Float64): Unit {
    }
}
class B <: A {
    func f(x!: Int32 = 7) { // This x's scope level is higher than the x at line 14
    }
}

main() {
    Assert.equals(0, a)
    Assert.equals(1, x)
    Assert.equals(3, A().x)
    Assert.equals(r'a', A().y)
    A().f(0, .0)
    B().f()
    B().f(x: 0)
}
