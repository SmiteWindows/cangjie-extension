/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a04_10

  @Level:         1

  @Assertion:    3.2.4(4) If the name x is a variable, the variable in the upper-scope is shadowed.
                 For specific rules on masking of member variables, see Chapter of “Class and Interface”.

  @Description:  Check specific rule on masking of member variables. Member variable must not be shadowed.

  @Mode:         compileonly

  @Negative:     yes

  @Issue: 0006124

*/

interface I {
    mut prop x: Int64;
}

open class A <: I {
    private var hidden = 0
    public mut prop x: Int64 {
        get() { hidden }
        set(value) { hidden = value }
    }
}

class B <: A {
    public var x = 1
}

main () {
}

