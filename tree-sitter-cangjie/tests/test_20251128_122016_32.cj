/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
  @Name:         03_02_03_02_a13_01

  @Level:         1

  @Assertion:    3.2.3.2(13) Function defined as func f (x!: Int32 = x) { } is invalid.

  @Description:  Check that the named argument cannot be defined thru himself.

  @Mode:         compileonly

  @Negative:     yes

  @Structure:    single

*/

main() {
    func foo(arg1! : Int32 = arg1) {}
}
