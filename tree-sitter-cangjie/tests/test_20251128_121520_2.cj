/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Description:     Contains structs with primary constructors with public member variables.

  @Structure:       complex-aux
  @CompileWarning:  no
*/

package p3

import utils.assert.Assert

public struct S1 {
    S1(public let a: Int64, public let b: Int64) {}
}
public struct S2 {
    S2(public let a: Int64, public var b: Int32) {}
}
public struct S3 {
    S3(public let a: Int64, public let b!: UInt64) {}
}
public struct S4 {
    S4(public let a: Int64, public var b!: UInt32) {}
}
public struct S5 {
    S5(public let a: Int64, public let b!: Int16=1+1) {}
}
public struct S6 {
    S6(public let a: Int32, public var b!: Int16=1+1) {}
}
public struct S7 {
    S7(public let a!: UInt64, public let b!: Int16) {}
}
public struct S8 {
    S8(public let a!: UInt32, public var b!: Int16=1+1) {}
}

// Checks constructor member variables are visible in the current package.
public func test() {
    let s1 = S1(0, 2)
    Assert.equals(0, s1.a)
    Assert.equals(2, s1.b)

    let s2 = S2(0, 2i32)
    Assert.equals(0, s2.a)
    Assert.equals(2, s2.b)

    let s3 = S3(0, b: 2u64)
    Assert.equals(0, s3.a)
    Assert.equals(2, s3.b)

    let s4 = S4(0, b: 2u32)
    Assert.equals(0, s4.a)
    Assert.equals(2, s4.b)

    let s5 = S5(0)
    Assert.equals(0, s5.a)
    Assert.equals(2, s5.b)

    let s5v2 = S5(0, b: 2i16)
    Assert.equals(0, s5v2.a)
    Assert.equals(2, s5v2.b)

    let s6 = S6(0i32)
    Assert.equals(0, s6.a)
    Assert.equals(2, s6.b)

    let s6v2 = S6(0i32, b: 2i16)
    Assert.equals(0, s6v2.a)
    Assert.equals(2, s6v2.b)

    let s7 = S7(a: 0u64, b: 2i16)
    Assert.equals(0, s7.a)
    Assert.equals(2, s7.b)

    let s8 = S8(a: 0u32)
    Assert.equals(0, s8.a)
    Assert.equals(2, s8.b)

    let s8v2 = S8(a: 0u32, b: 2i16)
    Assert.equals(0, s8v2.a)
    Assert.equals(2, s8v2.b)
}

// Next funcs return instances of the structs because our primary constructors aren't public, but outside this package
// only structs themselves (their names) and constructor member variables should be visible.
public func getS1() { S1(0, 2) }
public func getS2() { S2(0, 2i32) }
public func getS3() { S3(0, b: 2u64) }
public func getS4() { S4(0, b: 2u32) }
public func getS5v1() { S5(0) }
public func getS5v2() { S5(0, b: 2i16) }
public func getS6v1() { S6(0i32) }
public func getS6v2() { S6(0i32, b: 2i16) }
public func getS7() { S7(a: 0u64, b: 2i16) }
public func getS8v1() { S8(a: 0u32) }
public func getS8v2() { S8(a: 0u32, b: 2i16) }
