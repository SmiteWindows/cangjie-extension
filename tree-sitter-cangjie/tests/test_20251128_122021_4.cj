/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a04_01

  @Level:         1

  @Assertion:       2.1.11.5(4) Although T and Option<T> are different types, when it is clear that 
  a location requires a value of type Option<T>, you can pass a value of type T directly, 
  and the compiler will wrap the value of type T into the Some constructor of Option<T>.
 
  @Description:     Checks that compiler wraps plain values with options

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/

import utils.assert.Assert

struct S {
    S(var a: ?ToString) {}
}
type T = S
main() {
    var v1: ?Bool = true
    Assert.isTrue(v1 is Option<Bool>)
    Assert.isTrue(S('q').a is Option<ToString>)

    func f (x: ?(String, Range<UInt32>)) {}
    var fr: ?(Option<(String, Range<UInt32>)>) -> Unit = f
    match (fr) {
        case Some(x) => Assert.isTrue(x is (Option<(String, Range<UInt32>)>) -> Unit)
        case _ => Assert.fail()
    }
    let s:?T = S("qwert")

    f(("fgdfgr", 0..10))
}
