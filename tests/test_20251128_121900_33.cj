/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_02_a01_03

  @Level:         1
  @Assertion:    2.2.1.2(1) For an array instance arr, manners for accessing
                 elements in arr is showed as follows: Accessing an element at
                 a specific location: Element at a specific location can be
                 accessed through arr[index1]...[indexN]
                 (where index1,...,indexN is an expression for the index value,
                 whose types are all Int64).

  @Description:  Checks that array elements can't be accessed via index of
                 type UInt64

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    single

*/

main(): Int64 {
    let a = Array<Int64>(15) { i => 1 << i }

    let a10 = a[10u64]

    return 0
}
