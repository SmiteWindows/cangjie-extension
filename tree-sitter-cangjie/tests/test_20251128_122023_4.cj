/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_03_a03_03

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
    | add
    | add(Int64)
    | add(Int64, Int64)
    | add(Int64, Int64, Int64)

    static func sum(p: Math) {
        match(p) {
            case add => 2023
            case add(a) => a
            case add(a, b) => a + b
            case add(a, b, c) => a + b + c
        }
    }

    func callSum() { sum(this) }

    func addSumAndDouble() { callSum() + callSum() }
}

main() {
    var obj = add
    print(add.callSum())
    Assert.equals(2023, add.callSum())
    Assert.equals(2023, add(2023).callSum())
    Assert.equals(2023, add(2020, 3).callSum())
    Assert.equals(2023, add(2000, 20, 3).callSum())

    Assert.equals(4046, add.addSumAndDouble())
    Assert.equals(4046, add(2023).addSumAndDouble())
    Assert.equals(4046, add(2020, 3).addSumAndDouble())
    Assert.equals(4046, add(2000, 20, 3).addSumAndDouble())
}
