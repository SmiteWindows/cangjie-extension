/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a14_01

  @Level:         1

  @Assertion:    3.2.3.2(14) The scope of type parameters introduced when a generic type is declared or extension is 
                 defined start from the declaration of type parameters to the end of the type body or extension body.

  @Description:  Checks of the scope of type parameters for class and class extension.  

  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

open class A<T> {}

extend<T> A<T> {
    func foo(a : T) : T {
        let b : T = a
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return b
    }

    func bar<T>(a : T) : T {
        let b : T = a
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return b
    }
}


interface I<T> {
    static func foo(a : T) : T
}

open class B<T> <: I<T> {
    static public func foo(a : T) : T {
        let b : T = a
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return b
    }

    static public func bar<T>(a : T) : T {
        let b : T = a
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return b
    }
}

interface IG<T> {
    static func foo(a : T) : T {
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return a
    }

    static func bar<T>(a : T) : T {
        Assert.isTrue(a is T, reason : "a is not of T type.")
        return a
    }
}

open class C<T> <: IG<T> {}

main() {
    Assert.isTrue(A<Int32>().foo(1) is Int32)
    Assert.isTrue(A<Float64>().foo(1.0) is Float64)
    Assert.isTrue(A<String>().foo("test1") is String)
    Assert.isTrue(A<Int32>().bar<Int32>(1) is Int32)
    Assert.isTrue(A<Float64>().bar<Float64>(1.0) is Float64)
    Assert.isTrue(A<String>().bar<String>("test1") is String)

    Assert.isTrue(B<Int64>.foo(2) is Int64)
    Assert.isTrue(B<Float64>.foo(2.0) is Float64)
    Assert.isTrue(B<String>.foo("test2") is String)
    Assert.isTrue(B<Int64>.bar<Int64>(2) is Int64)
    Assert.isTrue(B<Float64>.bar<Float64>(2.0) is Float64)
    Assert.isTrue(B<String>.bar<String>("test2") is String)

    Assert.isTrue(C<Bool>.foo(true))
    Assert.isTrue(C<Float64>.foo(3.0) is Float64)
    Assert.isTrue(C<String>.foo("test3") is String)
    Assert.isTrue(C<Bool>.bar<Bool>(true))
    Assert.isTrue(C<Float64>.bar<Float64>(3.0) is Float64)
    Assert.isTrue(C<String>.bar<String>("test3") is String)
}
