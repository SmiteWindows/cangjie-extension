/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a08_02

  @Level:         1

  @Assertion:    2.1.6.1(8) 
// empty multi-line string
 let s1 = """
 """
 // Error: there must be a line terminator after the begining double quotations.
 let errorStr = """abc
 """
 /*
 The result of s2 is:
 This
 is a multi-line string
 */
 let s2 = """
 This
 is a multi-line string"""
 /*
 The result of s3 is:
 This
 is a multi-line string
 */
 let s3 = """
 This
 is a multi-line string"""
 /*
 The result of s4 is:
 This
 is a
 multi-line string
 */
 let s4 = """
 This
 is a
 multi-line string
 """
 /*
 The result of s5 is:
 This is a
 multi-line string
 */
 let s5 = """
 This is a\n
 multi-line string
 """

  @Description:  Negative example from specification.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

main() {
  // Error: there must be a line terminator after the begining double quotations.
  let errorStr = """abc
  """
}