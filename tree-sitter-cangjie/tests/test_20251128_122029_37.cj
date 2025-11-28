/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name: 02_01_10_02_a15_12

  @Level:         1

  @Assertion: 2.1.10.2(15)
              In the primary constructor, only non-static member variable declarations can be written.

  @Description: Check that a variable generated from
                a private let member variable named paremeter
                can not be accessed through the struct name

  @Mode: compileonly

  @Negative: yes

  @Structure: single

  @Issue: 0006183

*/

struct Test {
    Test(
        private let p!: Int64
    ) {}

    func check() {
        let tmp = Test.p
    }
}

main() {
    let tst = Test(p: 1)
    tst.check()
}