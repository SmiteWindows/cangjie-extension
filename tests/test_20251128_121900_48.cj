/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         01_03_04_a02_

  @Level:         1

  @Assertion:    1.3.4(2) It consists of a leading character b, a pair of single quotes and an ASCII character

  @Description:  Emit error for escaped '\$'

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert

main() {
    Assert.isTrue(b'\$'!= b'0')
    return 0
}

