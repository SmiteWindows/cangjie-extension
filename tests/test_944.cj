/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_02_a06_01

  @Level:         1

  @Assertion:    2.1.2(6)
    main() {
      'A'=='A' // result: true
      'A'!='A' // result: false
      'A'<'a' // result: true
      'A'<='A' // result: true
      'A'>'a' // result: false
      'A'>='A' // result: true
      return 0
    }

  @Description:

  @Mode:         run 

  @Negative:     no  

  @Structure:    single
 
*/

import utils.assert.Assert

main() {
  Assert.isTrue('A'=='A')
  Assert.isFalse('A'!='A')
  Assert.isTrue('A'<'a')
  Assert.isTrue('A'<='A')
  Assert.isFalse('A'>'a')
  Assert.isTrue('A'>='A')
  return 0
}