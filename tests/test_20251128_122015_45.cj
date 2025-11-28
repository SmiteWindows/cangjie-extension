/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_05_a07_01

  @Level:         1

  @Assertion:       2.1.10.5(7) Finally, note that structInstance (an instance of a struct type) does not support
                    changing the value of the member variable varName by means of structInstance.varName = expr if it
                    is defined by let (even though the varName is defined using var);

  @Description:     Check that it isn't possible to change a member variable defined with `let` on an immutable struct
                    instance.

  @Mode:            compileonly
  @Negative:        yes
  @Structure:       single
  @CompileWarning:  no

*/

struct S {
    let varName = 15
}

main() {
    let structInstance = S()
    structInstance.varName = 13
}
