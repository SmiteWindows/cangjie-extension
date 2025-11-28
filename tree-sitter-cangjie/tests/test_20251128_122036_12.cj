/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:            03_02_03_02_a06_08

  @Level:         1

  @Assertion:       3.2.3.2(6) Local function scope starts after the function defined 
                    and ends with the closing of the block.

  @Description:     Checks declaration of local function into try-finally expression.

  @Mode:            compileonly

  @Negative:        yes

  @Structure:       single

*/

main() {
    try {
    } catch (_) {
    } finally {
        foo()
        func foo() : Int32 { return 1 }
    }
}



