/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_03_a01_02

  @Level:         1
  @Assertion:       2.1.8.3(1) When defining Range<T> variables, the type annotation can be added
                    or omitted (inferred by the compiler in this situation).

  @Description:     Checks that range variables (let) have equal types.

  @Mode:            run
  @Negative:        no
  @Structure:       single

*/

import utils.assert.Assert

main() {
  let a1: Range<Int8>       = 0..10
  let a2: Range<Int16>      = -5..=10
  let a3: Range<Int32>      = 10..=10
  let a4: Range<Int64>      = 8..10:2
  let a5: Range<UInt8>      = 0..10
  let a6: Range<UInt16>     = 5..=10
  let a7: Range<UInt32>     = 12..=10
  let a8: Range<UInt64>     = 80..100:2

  let b1 = 0i8..10i8
  let b2 = -5i16..=10i16
  let b3 = 10i32..=10i32
  let b4 = 8i64..10i64:2
  let b5 = 0u8..10u8
  let b6 = 5u16..=10u16
  let b7 = 12u32..=10u32
  let b8 = 80u64..100u64:2

  Assert.equals(a1, b1)
  Assert.equals(a2, b2)
  Assert.equals(a3, b3)
  Assert.equals(a4, b4)
  Assert.equals(a5, b5)
  Assert.equals(a6, b6)
  Assert.equals(a7, b7)
  Assert.equals(a8, b8)
  return 0
}
