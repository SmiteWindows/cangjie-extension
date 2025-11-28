/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_03_01_a03_02

  @Level:         1

  @Assertion:    3.3.1(3) The modifiers of top-level variables include public.

  @Description:  Check that variable declaration using wrong syntax will produce error on compilation.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    public myLocalVar: String = "AAA"
}