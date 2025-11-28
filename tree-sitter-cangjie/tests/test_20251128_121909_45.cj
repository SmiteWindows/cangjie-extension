/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a07_01

  @Level:         1

  @Assertion:       2.1.11.5(7) The following shows the declaration and initialization of variables of Option type:
 let opInt32_1 = Some(100) // The type of 'opInt32_1' is 'Option<Int32>'
 let opInt32_2 = Option<Int32>.None // The type of 'opInt32_2' is 'Option<Int32>'
 let opChar = Some('m') // The type of 'opChar' is 'Option<Rune>'
 let opBool = Option<Bool>.None // The type of 'opBool' is 'Option<Bool>'
 let opEnum = Some(TimeUnit1.Year) // The type of 'opEnum' is 'Option<TimeUnit1>'
 
  @Description:     Checks that positive examples behave as expected

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @Issue:           6451

  @Comment:

*/
import utils.assert.Assert

enum TimeUnit1 { Year }

main() {
    let opInt32_1 = Some(100) // The type of 'opInt32_1' is 'Option<Int32>'
    Assert.isTrue(opInt32_1 is ?Int64)
    let opInt32_2 = Option<Int32>.None // The type of 'opInt32_2' is 'Option<Int32>'
    Assert.isTrue(opInt32_2 is ?Int32)
    let opChar = Some(r'm') // The type of 'opChar' is 'Option<Rune>'
    Assert.isTrue(opChar is ?Rune)
    let opBool = Option<Bool>.None // The type of 'opBool' is 'Option<Bool>'
    Assert.isTrue(opBool is ?Bool)
    let opEnum = Some(TimeUnit1.Year) // The type of 'opEnum' is 'Option<TimeUnit1>'
    Assert.isTrue(opEnum is ?TimeUnit1)
}
