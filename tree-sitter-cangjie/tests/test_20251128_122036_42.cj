/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:        02_03_01_a01_02

  @Level:         1

  @Assertion:   2.3.1(1) Type conversion from Rune to UInt32.

  @Description:  Check that the type conversion from Rune to Int8 is not supported

  @Mode:         compileonly

  @Negative:     yes

*/

let a1 = 'o'
var r1 = Int8(a1)

main(): Unit {}

