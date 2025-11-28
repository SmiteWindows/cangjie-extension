/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a05_65

  @Level:         1
  @Assertion:       2.1.1.2(5) If arithmetic operators are not overload (see section operator overloading), the operands
                    of them must have the same type.

  @Description:     Checking that it isn't possible to call arithmetic operators on different types.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

main() {
    .0f64 ** 1u64
}
