/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a06_04

  @Level:         1

  @Assertion:    2.1.6.1(6) If non-escaped three double quotations is not matched before the end of
                 current file, a compiler error is reported.

  @Description:  Unterminated local multy-line string literal inside func produce an error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

func myFunc() {
  var myFuncLocalVar = """
  \u{1097}
  myFuncLocalVar
}
main() {
}