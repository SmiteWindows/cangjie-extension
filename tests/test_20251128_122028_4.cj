/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a14_01

  @Level:         1

  @Assertion:       2.1.11.5(14) When the value of e1 is equal to Option<T>.Some(v), 
  the value of e1 ?? e2 has a value equal to the value of v; 
  the value of e1 ?? e2 is equal to the value of e2 when e1 equals to Option<T>.None.

 
  @Description:     Checks value of Option coalescing expressions for simple values

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

main() {
    var a = Some(123) ?? 321
    Assert.equals(123, a)
    let b = None<Rune> ?? r'f'
    Assert.equals(r'f', b)
}
