/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a01_01

  @Level:         1
  @Assertion:    2.2.1(1) The Array type is written as a generic type Array<T>

  @Description:  Checks that variable of type Array can be created

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

enum A {
    AA1 | AA2 | AA3
}

main(): Int64 {
    let a1: Array<Int32> = []
    let a2: Array<Float64> = []
    let a3: Array<Bool> = []

    let a4 = Array<A>()

    Assert.isTrue(a1 is Array<Int32>)
    Assert.isTrue(a2 is Array<Float64>)
    Assert.isTrue(a3 is Array<Bool>)
    Assert.isTrue(a4 is Array<A>)

    return 0
}
