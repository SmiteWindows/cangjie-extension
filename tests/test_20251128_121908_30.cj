/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_11_05_a06_01

  @Level:         1

  @Assertion:       2.1.11.5(6) For two types T1 and T2 that are not equal , 
  there is no subtype relationship between Option<T1> and Option<T2> even if T1 and T2 have a subtype relationship.
 
  @Description:     Checks that ?String and ?ToString have no subtype relation

  @Mode:            run
  @Negative:        no
  @Structure:       single

  @Comment:

*/
import utils.assert.Assert

main() {
    Assert.isTrue("str" is ToString)
    Assert.isTrue(None<String> is ?String)
    Assert.isFalse(None<String> is ?ToString)
}
