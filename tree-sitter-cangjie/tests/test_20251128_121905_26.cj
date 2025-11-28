/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_01_a07_01

  @Level:         1
  @Assertion:       2.1.11.1(7) A constructor with parameters has a function type, but it is not a first-class citizen.

  @Description:     Checks type of parameterized enum instance

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

import utils.assert.Assert

enum A {
    B1(Bool) | B2(Int32, Rune)
}

func F1(b: Bool) : A {
    return B1(b)
}


main() {
    let b1 = A.B1(true)
    Assert.isTrue(b1 is A);
    Assert.isFalse(b1 is (Bool) -> A);

    Assert.isTrue(F1 is (Bool) -> A);
    var f = {b: Bool => if (b) {F1(b)} else {B2(0,r'a')}}
    var b2 = f(false)
    Assert.isTrue(b2 is A)
    
    f = F1
    b2 = f(false)
    Assert.isTrue(b2 is A)
 }
