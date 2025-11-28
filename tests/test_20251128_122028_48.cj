/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_04_a02_05

  @Assertion:    3.2.4(2) Note that shadowing ends when the lower-scope ends.

  @Description:  Demo for assertion error

  @Mode:         run

  @Negative:     no

  @Structure:    single

  @Comment:

*/
import utils.assert.Assert

let idLet = "global_var"

struct Type {
    static let idFunc: Int32 = 100

    let idLet: String

    Type() {
        idLet = "false"
        Assert.equals("global_var", idLet)
    }
}

main() {
    let t = Type()
}