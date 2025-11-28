/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_01_02_a13_01

  @Level:         1
  @Assertion:       2.1.1.2(13) In addition, the increment (decrement) operators can only be used as the postfix
                    operators, and can only be applied to integer variables, as the values of constants and integer
                    literals cannot be modified.

  @Description:     Check that the prefix increment cannot be used for Int8.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

main() {
    var i: Int8 = 1
    ++i
    0
}
