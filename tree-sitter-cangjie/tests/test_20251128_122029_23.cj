/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         bug_0006023
  @Assertion:    Bog 0006023: A non-working example of complex macros in the specification.
  @Description:  Checks a non-working example of complex macros in the specification.
  @Mode:         run
  @Negative:     no

  @Structure:    complex-main
  @Dependencies: C/C.cj
*/

import c.*
public import b.*

main() {
  var input = 111
  @M1(input)
  F1(input)
  @M2(input)
  return 0
}
