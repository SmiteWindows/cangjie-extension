/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0005938
  @Assertion:       [ICE] Using incompatible enum constructor in for-in

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Comment:         CompilerBug, fixed in v0.38.2
*/

enum E { A | B(Int64) }

main() {
    let arr = [ A, B(0) ]
    for(E.A(x) in arr) {}
}
