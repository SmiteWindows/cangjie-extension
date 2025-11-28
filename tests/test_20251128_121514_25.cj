/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a04_06

  @Level:         1

  @Assertion:    3.2.4(4) If the name x is a variable, the variable in the upper-scope is shadowed.
                 For specific rules on masking of member variables, see Chapter of “Class and Interface”.

  @Description:  Check specific rule on masking of member variables. Member variable must not be shadowed.

  @Mode:         compileonly

  @Negative:     yes

*/

open class A {
    let x = 1
}

class B <: A {
    let x = 2
}

main () {
}

