/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a08_01

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

  @Description:  Positive examples from specification.

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:      

*/
import utils.assert.Assert

main() {
  // empty multi-line string
  let s1 = """
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

  Assert.isTrue(s1 is String)
  Assert.equals(s2, """
  This
  is a multi-line string""")
  Assert.isTrue(s2 is String)
  Assert.equals(s3, """
  This
  is a multi-line string""")
  Assert.isTrue(s3 is String)
  Assert.equals(s4, """
  This
  is a
  multi-line string
  """)
  Assert.isTrue(s4 is String)
  Assert.equals(s5, """
  This is a\n
  multi-line string
  """)
  Assert.isTrue(s5 is String)

}