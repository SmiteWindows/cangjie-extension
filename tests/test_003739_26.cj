/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:       bug_0005922
  @Assertion:  Issue 0005922: Compiler do not permit more than 2 digits in Byte 
               Array Literal for unicode chars although language declaration 
               permits and single char permits
  Description: The test case uses the "character byte literal" syntax, BNF 
               allows only two hexadecimal characters existence within braces.
  @Mode:       compileonly
  @Negative:   yes
  @Structure:  single
*/

main() {
  println('\u{7fffffff}' is Rune)
  b"\u{0030}\u{0031}"
}
