/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a13_85

  @Level:         1
  @Assertion:       2.1.1.2(13) In addition, the increment (decrement) operators can only be used as the postfix
                    operators, and can only be applied to integer variables, as the values of constants and integer
                    literals cannot be modified.

  @Description:     Check that the increment cannot be used with a literal after casting it to the Int8.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

main() {
    Int8(16)++
    0
}
