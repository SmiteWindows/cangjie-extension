/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a06_11

  @Level:         1
  @Assertion:       2.1.1.2(6) Explicit type conversion must be performed first to perform operations on operands with
                    different types.

  @Description:     Check that it isn't possible to use + with operands of different types (UIntNative and Int32).

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Comment:         ** isn't checked because the power operator only allows different types (Int64 and UInt64). See
                    comment on issue 6166.
  @Issue:           0006166
*/

main() {
    UIntNative(1) + 1i32
}
