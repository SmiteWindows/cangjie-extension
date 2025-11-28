/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a08_01

  @Level:         1
  @Assertion:    2.2.1(8) Multidimensional arrays are defined as
                 'arrays of array' with the format Array<Array<...>>.
                 For example, Array<Array<Int32>> indicates a two-dimensional
                 array with the type of element is Int32.

  @Description:  Checks that multi-dimentional can be created and behaves as
                 expected

  @Mode:         run
  @Negative:     no
  @Structure:    single

*/
import utils.assert.*

main(): Int64 {
    // create and check 6th-dimentional array
    let a: Array<Array<Array<Array<Array<Array<Int32>>>>>> = [[[[[[6]]]]]]

    Assert.isTrue(a is Array<Array<Array<Array<Array<Array<Int32>>>>>>)
    Assert.isTrue(a[0] is Array<Array<Array<Array<Array<Int32>>>>>)
    Assert.isTrue(a[0][0] is Array<Array<Array<Array<Int32>>>>)
    Assert.isTrue(a[0][0][0] is Array<Array<Array<Int32>>>)
    Assert.isTrue(a[0][0][0][0] is Array<Array<Int32>>)
    Assert.isTrue(a[0][0][0][0][0] is Array<Int32>)
    Assert.isTrue(a[0][0][0][0][0][0] is Int32)

    return 0
}
