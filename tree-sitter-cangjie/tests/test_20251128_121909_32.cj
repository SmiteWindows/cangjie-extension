/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
/*
  @Name:         02_02_01_a02_03

  @Level:         1
  @Assertion:    2.2.1(2) Arrays are used to store a sequence of values of the
                 same type (or has a common super type).

  @Description:  Checks that values of Int8 can't be added to Array<Int64>

  @Mode:         compileonly
  @Negative:     yes
  @Structure:    single

*/

main(): Int64 {
    let a1 = Array<Int64>(10){ i => 0 }
    a1[0] = 34i8

    return 0
}
