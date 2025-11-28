/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006068
  @Assertion:       quote() without input

  @Description:     According to Spec, calling `quote()` is illegal, but the compiler doesn't throw an error.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Comment:         CompilerBug v0.37.2, v0.38.2 or SpecBug v0.22.12, v0.22.13, v0.22.14
*/

import std.ast.*

main() {
    quote()
    0
}
