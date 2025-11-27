/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_02_a02_01

  @Level:         1
  @Assertion:       2.1.8.2(2) When instances of type Range<Int64> are used in the index access
                    operator [], both start and end are optional.

  @Description:     Checks that both start and end of range can be omitted (when Int64).

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single

  @Comment:

*/

main() {

  let array = [-3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8]

  array[..=4i64]
  array[10i64..]
  array[5i64..]
  array[..]
  return 0
}
