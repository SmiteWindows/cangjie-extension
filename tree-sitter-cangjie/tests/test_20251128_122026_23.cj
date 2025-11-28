/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:            02_01_10_04_a02_05

  @Level:         1
  @Assertion:       2.1.10.4(2) The visibility of struct members can be controlled by the visibility modifiers public
                    or private. In addition, static members can be declared using the static modifier.

  @Description:     Check that struct members can be modified with the "private static" modifier.

  @Mode:            compileonly
  @Negative:        no
  @Structure:       single
  @CompileWarning:  no

  @Issue: 0006124

*/

struct S {
    private static let v = 64
    private static prop p: Int64 {
        get() { 2 }
    }

    private static func f() { 3 }
    private static func t<T>() { 4 }

    static func test() {
        v
        p
        f()
        t<Nothing>()
    }
}

main() {}
