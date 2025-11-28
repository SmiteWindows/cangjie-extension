/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            bug_0006117_01
  @Assertion:       Calling interface func with super modifier results in a compilation error

  @Description:     A parent interface function can be called without the super modifier, but not with the super
                    modifier.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

  @Comment:         Not a Bug, so the test has been changed from positive to negative.
*/

interface I {
    func f() {}
}

class C <: I {
    func g() {
        super.f()
    }
}

main() {}
