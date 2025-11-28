/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a07_01

  @Level:         1
  @Assertion:    2.2.1(7) Only when the concrete type Type in Array<T> supports
                 using ==(! =) for equality (inequality) comparison, Array<T>
                 supports == and ! =, otherwise, Array<T> does not support ==
                 and ! = (a compilation error will be generated when using ==
                 and ! = for comparison).
                 We say two instances of Array<T> (with the same type) are
                 equal, if and only if elements in the same position (i.e.,
                 index) are all equal, which means they have the same length.

  @Description:  Checks that equality works as expected for Arrays of types
                 implementing Equatable interface

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

class A <: Equatable<A> {
    public var val: Int64

    public init(val: Int64) {
        this.val = val
    }

    public operator func ==(that: A): Bool {
        this.val == that.val
    }

    public operator func !=(that: A): Bool {
        this.val != that.val
    }
}

main(): Int64 {
    let a1: Array<Int32> = [1, 2, 3, 4, 5]
    let a2: Array<Int32> = [1, 2, 3, 4, 5]
    let a3: Array<Int32> = [5, 4, 3, 2, 1]
    let a4: Array<Int32> = [1, 2, 3, 4]

    // ==
    Assert.isTrue(a1 == a2)
    Assert.isFalse(a2 == a3)
    Assert.isFalse(a1 == a4)

    // !=
    Assert.isFalse(a1 != a2)
    Assert.isTrue(a2 != a3)
    Assert.isTrue(a1 != a4)

    let a5: Array<A> = [A(1), A(2), A(3), A(4), A(5)]
    let a6: Array<A> = [A(1), A(2), A(3), A(4), A(5)]
    Assert.isTrue(a5 == a6)

    return 0
}
