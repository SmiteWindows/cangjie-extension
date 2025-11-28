/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a04_22

  @Level:         1

  @Assertion:    2.1.6.1(4) A multi-line string literal consists of zero or more valid characters (except
                 alone character \ and non-escaped characters """) enclosed by a pair of three double
                 quote characters ("""), which begins after the line terminator of beginning double
                 quotations and ends before the first matched non-escaped ending double quotations.

  @Description:  Immutable private class member variable with non-escape characters """.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

class myClass{
  private let myPrivateLetMultyLine: String = """
  """
  """
}

main() {
}