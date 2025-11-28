/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_02_a04_02

  @Level:         1

  @Assertion:    2.1.6.2(4) A sequence of expressions and decalrations are allowed within the enclosing pair of curly brakets same as blocks, however, empty sequence is forbidden.

  @Description:  Check that empty sequence is forbidden.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      Need more variants

*/
public var testA0402: String = "SDRH==R${  }"
main() {
}