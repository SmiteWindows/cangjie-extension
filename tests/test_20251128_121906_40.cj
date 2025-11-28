/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a07_02

  @Level:         1

  @Assertion:    3.2.3.2(7) As a result, mutual recursion is not supported, but can call itself recursively.

  @Description:  Check that the mutual recursion is not supported.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

  @Comment:      Local function scope starts after the function defined and ends with the closing of the block.

*/

main() {
    func foo1(): Int32 {
        func foo2(): Int32 {
            return foo3()
        }

        func foo3(): Int32 {
            return foo2()
        }

        foo2()
    }

    foo1()
}