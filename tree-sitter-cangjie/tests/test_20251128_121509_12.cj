/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a11_03

  @Level:         1

  @Assertion:    3.2.3.2(11) Its scope level is the same as the variables defined in the function body.

  @Description:  Check that the function argument is inaccessible after the function declaration.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    func foo(a : Int32) {}
    a
}
