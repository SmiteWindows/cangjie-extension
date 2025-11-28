/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a02_06

  @Level:         1

  @Assertion:    3.2.4(2) Note that shadowing ends when the lower-scope ends.

  @Description:  Check different kinds of scopes.
                 Check that type-internal scope is used when local scope ends. Struct case.

  @Mode:         run

  @Negative:     no

*/

import utils.assert.Assert

struct Type<T> {
    static let v1: Int32 = 100
    var v2: T
    let f1: () -> Int32 = {
        => if (true) {
               let T = "foo"
               let v1 = "foo"
               let v2 = "foo"
               let f1 = "foo"
               let f2 = "foo"
               Assert.equals("foofoofoofoofoo", T+v1+v2+f1+f2)
           }
           v1
    }
    func f2(): T {
        if (true) {
            let T = "foo"
            let v1 = "foo"
            let v2 = "foo"
            let f1 = "foo"
            let f2 = "foo"
            Assert.equals("foofoofoofoofoo", T+v1+v2+f1+f2)
        }
        v2
    }

    Type(x: T) {
        if (true) {
            let T = "foo"
            let v1 = "foo"
            let v2 = "foo"
            let f1 = "foo"
            let f2 = "foo"
            Assert.equals("foofoofoofoofoo", T+v1+v2+f1+f2)
        }
        v2 = x
        Assert.equals(100, f1())
    }
}

main() {
    let s = Type<Bool>(true)
    Assert.equals(true, s.f2())
}
