/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a14_02

  @Level:         1

  @Assertion:       2.1.11.5(14) When the value of e1 is equal to Option<T>.Some(v), 
  the value of e1 ?? e2 has a value equal to the value of v; 
  the value of e1 ?? e2 is equal to the value of e2 when e1 equals to Option<T>.None.

 
  @Description:     Checks value of Option coalescing expressions for nested Option values

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

main() {
    var a = Some(Some(345))
    var b = a ?? None<Int64>
    Assert.isTrue(b is Option<Int64>)
    Assert.equals(345, b.getOrThrow())

    let c = None<Rune>
    let d = Some(c) ?? Some(r'g')
    Assert.isTrue(d is Option<Rune>)
    Assert.throws({ => d.getOrThrow() }, check: { e => e is NoneValueException})

    var e = Some(a) ?? Some(None<Int64>)
    Assert.isTrue(e is Option<Option<Int64>>)
    Assert.equals(345, e.getOrThrow() ?? 546)
}
