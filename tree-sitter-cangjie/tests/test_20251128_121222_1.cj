/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a05_02

  @Level:         1

  @Assertion:    2.1.6.1(5) There must be a line terminator after the beginning double quotations,
                 otherwise a compiler error is reported.

  @Description:  Absent line terminator in public top-level string literal.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/
public var testA0502 = """qawtgas
"""
main() {
}