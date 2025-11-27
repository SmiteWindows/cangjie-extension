/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_08_01_a02_01

  @Level:         1
  @Assertion:       2.1.8.1(2) It is required that the expression start and the expression end
                    have the same type and that step be of type Int64.  

  @Description:     Checks that range with specified requirements are compiler w/o errors.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single

  @Comment:

*/

main() {
  let a1 = 0i8..5i8
  let a2 = 0u16..=5u16:2i64
  let a3 = 10i32..=0i32:-2i64
  let a4 = 10u64..0u64:333i64
  return 0
}
