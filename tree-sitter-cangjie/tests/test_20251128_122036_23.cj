/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_a01_01

  @Level:         1
  @Assertion:       2.1.8(1) The Range type is written as Range<T>, where T can only be
                    instantiated as types that implement the Comparable interface and the
                    AddInt64 interface.

  @Description:     Checks that types that implement Countable and Comparable can be used for ranges.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @Issue:           0006079

*/

func range<T>(a: T, b: T): Range<T> where T <: Countable<T> & Comparable<T> {
  a..b
}

main() {
  let a1 = range(0, 10)
  let a2 = range(0u8, 10u8)
  let a3 = range(0i16, 10i16)
  return 0
}
