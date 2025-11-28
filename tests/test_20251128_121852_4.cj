/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a03_01

  @Level:         1

  @Assertion:    3.2.3.3(3) The scope of the enum constructor names is in the entire enum definition.
                  More detailed description of enum constructors are in enum Type.

  @Description:  Check that enum constructor names can be accessible inside the enum definition.
  
  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

enum MathSign {
    | add | mul | div | sub

    static func getSign(p: MathSign) {
        match (p) {
            case add => "+"
            case mul => "*"
            case div => "/"
            case sub => "-"
        }
    }

    func callGetSign() { getSign(this) }
}

main() {
    Assert.equals("+", add.callGetSign())
    Assert.equals("*", mul.callGetSign())
    Assert.equals("/", div.callGetSign())
    Assert.equals("-", sub.callGetSign())

    Assert.equals("+", MathSign.getSign(add))
    Assert.equals("*", MathSign.getSign(mul))
    Assert.equals("/", MathSign.getSign(div))
    Assert.equals("-", MathSign.getSign(sub))
}
