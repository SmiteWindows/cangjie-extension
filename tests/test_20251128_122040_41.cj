/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:           02_01_11_04_a01_04

  @Level:         1

  @Assertion:      2.1.11.4(1) Member functions and member attributes can also be defined in enum.


  @Description:     Checks that static member properties can be defined and used

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Issue: 0006124

*/
import utils.assert.Assert

enum E<T> {
    | A
    | B(T)
    static prop x: Int64 {
        get() { 42 }
    }
}

main() {
    Assert.equals(42, E<UInt8>.x)
    Assert.equals(42, E<Rune>.x)
}
