/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a10_03

  @Level:         1

  @Assertion:    3.2.3.2(10) The scope of a function type parameters and parameters start after 
                 the parameters defined and ends with the closing of the function body.

  @Description:  Check that the function parameter cannot be used after function body.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    func foo(arg : Int32) {}
    arg
}
