/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         02_01_06_01_a10_02

  @Level:         1

  @Assertion:    2.1.6.1(10) If another double quotation (") and the same number of # characters as the
                 beginning is not matched before the end of current file, a compiler error is reported.

  @Description:  Check that double quotation (") and the different number of number signs (#) inside
                 local-level multy-line raw string literal produce an error.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      

*/

main() {
  let myPublicTopLetRawMultyLine: String = ##""#
}