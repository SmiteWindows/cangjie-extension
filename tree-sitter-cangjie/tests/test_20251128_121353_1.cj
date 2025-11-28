/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006121_04
  @Assertion:       Generic type and classes/funcs with the same names

  @Description:     extend C<T> { func T() }

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Comment:         CompilerBug v0.38.2 or SpecBug v0.22.14
*/

class C<T> {}

extend C<T> {
    func T() {}
}

main() {}
