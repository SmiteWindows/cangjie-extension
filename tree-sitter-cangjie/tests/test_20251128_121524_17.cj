/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a13_46

  @Level:         1
  @Assertion:       2.1.1.2(13) In addition, the increment (decrement) operators can only be used as the postfix
                    operators, and can only be applied to integer variables, as the values of constants and integer
                    literals cannot be modified.

  @Description:     Check that the decrement cannot be used with UInt16 constant.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

main() {
    let i: UInt16 = 1
    i--
    0
}
