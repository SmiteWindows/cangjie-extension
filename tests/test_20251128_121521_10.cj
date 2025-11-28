/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006351
  @Assertion:       Interpolated str and packages with the same name from different modules

  @Description:     Must be a compilation error.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       complex-main
  @Dependencies:    m1/m1_p.cj m2/m2_p.cj
  @CompileWarning:  no

  @Comment:         CompilerBug v0.38.2. Verified for the Spec v0.22.14
*/

import m1.p.f
import m2.p.f

main() {
    println("${p.f()}")
}
