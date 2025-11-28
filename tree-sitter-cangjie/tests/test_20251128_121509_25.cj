/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006070
  @Assertion:       Divergent calculations when capturing a mut var and creating a Nothing var

  @Description:     The code below runs indefinitely and probably shouldn't.

  @Mode:            run
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Comment:         CompilerBug v0.35.6, v0.37.2, v0.38.2. Verified for the Spec v0.22.12, v0.22.13, v0.22.14
*/

main() {
    var a = 0
    { =>
        func t<T>() { let unused: T }
        t<Nothing>()
        a
    }()
}
