/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a04_08

  @Level:         1

  @Assertion:    3.3.1(4) Local variables cannot be modified with modifiers.

  @Description:  Check that local variable declaration can not include modifiers.
                 Case: local-level mutable variable can't be defined using 'static' modifier

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    static var myLocalVar: String = "AAA"
}