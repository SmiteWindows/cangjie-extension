/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a03_02

  @Level:         1

  @Assertion:    3.2.3.3(3) The scope of the enum constructor names is in the entire enum definition.
                  More detailed description of enum constructors are in enum Type.

  @Description:  Check that enum constructor names can be accessible inside the enum definition.
  
  @Mode:         run

  @Negative:     no

  @Structure:    single

*/

import utils.assert.Assert

enum Math {
    | add(Int64, Int64)
    | mul(Int64, Int64)
    | div(Int64, Int64)
    | sub(Int64, Int64)

    static func doMath(p: Math) {
        match(p) {
            case add(y, m) => y + m
            case mul(y, m) => y * m
            case div(y, m) => y / m
            case sub(y, m) => y - m
        }
    }

    func callDoMath() { doMath(this) }
}

main() {
    Assert.equals(2023, add(2000, 23).callDoMath())
    Assert.equals(2023, mul(119, 17).callDoMath())
    Assert.equals(2023, div(20230, 10).callDoMath())
    Assert.equals(2023, sub(2100, 77).callDoMath())

    Assert.equals(2023, Math.doMath(add(2020, 3)))
    Assert.equals(2023, Math.doMath(mul(289, 7)))
    Assert.equals(2023, Math.doMath(div(4046, 2)))
    Assert.equals(2023, Math.doMath(sub(3000, 977)))
}
