/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_04_a03_01

  @Level:         1
  @Assertion:    2.2.1.4(3) The type returned by slicing is still the same
                 Array type and is a reference to the original Array.
                 Changes to the elements in the slice will affect the original
                 array.

  @Description:  Checks that slice creates reference to the original array of
                 same type

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    let size = 20
    let a = Array<Int64>(size) { i => 1 << i }

    let s = a[5..]

    Assert.isTrue(s is Array<Int64>)

    s[5] = 10
    Assert.equals(10, a[10])

    a[12] = 2
    Assert.equals(2, s[7])

    return 0
}
