/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         bug_0005805

  @Description:  Top-level class name is not shadowed

  @Mode:         compileonly

  @Negative:     no

  @Structure:    single

  @Comment:      Fixed in v0.37.2
*/

class C {} // if this line is commented, test compiles

struct S {
    func C(): String { "ok" }
    func test() {
        let str: String = C()
    }
}

main() {
    let s = S()
    0
}

